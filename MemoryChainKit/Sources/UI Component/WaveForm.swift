//
//  WaveformComponent.swift
//  WaveformDemo
//
//  Created by Marc Steven on 2020/5/27.
//  Copyright © 2020 www.richandyoung.cn. All rights reserved.
//

import UIKit

let normalColor = UIColor.white
let normalAlphaColor = UIColor.init(white: 1.0, alpha: 0.5)
let highlightColor = UIColor.init(red: 163.0/255.0, green: 243.0/255.0, blue: 16.0/255.0, alpha: 1.0)
let highlightAlphaColor = UIColor.init(red: 163.0/255.0, green: 243.0/255.0, blue: 16.0/255.0, alpha: 0.24)
let waveWidth = CGFloat(2.5)
let waveSpace = CGFloat(0.5)
let waveRadius = CGFloat(1.25)
let upMaxHeight = CGFloat(60)
let downMaxHeight = CGFloat(30)
let upDownSpace = CGFloat(2)

protocol WaveformScrollDelegate: NSObjectProtocol {
    func didScrollToTime(time: NSInteger)
}

class WaveformComponent: UIView, CAAnimationDelegate {

    private var timeLine: UILabel!
    private var topView: WaveformView!
    private var topViewMask: CALayer!
    private var bottomView: WaveformView!
    private var isAnimated = false
    private let convertTime = {
        (seconds: Int) -> String in
        let minute = seconds / 60
        let minuteStr = minute > 9 ? "\(minute)" : "0\(minute)"
        let second = seconds % 60
        let secondStr = second > 9 ? "\(second)" : "0\(second)"
        return "\(minuteStr):\(secondStr)"
    }
    private var animationTimer: Timer!
    weak var delegate: WaveformScrollDelegate?
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(frame: CGRect, amplitudes: [Double]) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.isOpaque = true
        let width = (waveWidth + waveSpace) * CGFloat(amplitudes.count / 2)
        let height = upMaxHeight + downMaxHeight + upDownSpace
        let waveRect = CGRect.init(x: frame.size.width/2.0, y: (frame.size.height - height)/2.0, width: width, height: height)
        
        bottomView = WaveformView.init(frame: waveRect, amplitudes: amplitudes, isHighlight: true)
        self.addSubview(bottomView)
        
        topView = WaveformView.init(frame: waveRect, amplitudes: amplitudes, isHighlight: false)
        self.addSubview(topView)
        
        topViewMask = CALayer()
        topViewMask.frame = topView.bounds
        topViewMask.backgroundColor = UIColor.white.cgColor
        topView.layer.mask = topViewMask
        
        timeLine = UILabel.init(frame: CGRect.init(x: (frame.size.width - 61.5)/2.0, y: (frame.size.height - upMaxHeight - upDownSpace - downMaxHeight)/2.0 + upMaxHeight - 19.0, width: 61.5, height: 19.0))
        timeLine.backgroundColor = UIColor.init(red: 18/255.0, green: 18/255.0, blue: 18/255.0, alpha: 0.72)
        timeLine.layer.cornerRadius = 9.5
        timeLine.layer.masksToBounds = true
        timeLine.textColor = UIColor.white
        timeLine.font = UIFont.init(name: "PingFangSC-Regular", size: 8.0)
        timeLine.textAlignment = .center
        timeLine.text = "\(convertTime(0))/\(convertTime(amplitudes.count/2))"
        self.addSubview(timeLine)
        
        let panGesture = UIPanGestureRecognizer.init(target: self, action: #selector(handleGesture(gesture:)))
        addGestureRecognizer(panGesture)
        isUserInteractionEnabled = true
    }
    
    func play() {
        if !isAnimated {
            isAnimated = true
            topView.layer.add(keyframeAnimationFrom(topView.layer.position.x, to: (self.bounds.size.width - topView.layer.bounds.size.width)/2, isTop: false), forKey: "pan")
            topViewMask.add(keyframeAnimationFrom(topViewMask.position.x, to: topViewMask.bounds.size.width*3/2, isTop: false), forKey: "pan")
            bottomView.layer.add(keyframeAnimationFrom(bottomView.layer.position.x, to: (self.bounds.size.width - bottomView.layer.bounds.size.width)/2, isTop: false), forKey: "pan")
            weak var weakSelf = self
            animationTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
                guard let presentation = weakSelf?.topView.layer.presentation() else { return }
                let delta = (weakSelf!.bounds.size.width + weakSelf!.topView.bounds.size.width)/2 - presentation.position.x
                weakSelf!.timeLine.text = "\(weakSelf!.convertTime(Int(round(delta / 3))))/\(weakSelf!.convertTime(weakSelf!.topView.amplitudes.count/2))"
            })
        }
    }
    
    func pause() {
        if isAnimated {
            topView.layer.position = topView.layer.presentation()!.position
            topViewMask.position = topViewMask.presentation()!.position
            bottomView.layer.position = bottomView.layer.presentation()!.position
            removeAnimate()
        }
    }
    
    @objc private func handleGesture(gesture: UIPanGestureRecognizer) {
        if gesture.state == .changed {
            let translation = gesture.translation(in: self)
            let absX = abs(translation.x)
            let absY = abs(translation.y)
            if (absX > absY ) {
                if (translation.x < 0) {
                    //向左滑动
                    if isAnimated {
                        topView.layer.position = CGPoint.init(x: max(topView.layer.presentation()!.position.x + translation.x, (self.bounds.size.width - topView.layer.bounds.size.width)/2), y: topView.layer.position.y)
                        topViewMask.position = CGPoint.init(x: min(topViewMask.presentation()!.position.x - translation.x, topViewMask.bounds.size.width*3/2), y: topViewMask.position.y)
                        bottomView.layer.position = CGPoint.init(x: max(bottomView.layer.presentation()!.position.x + translation.x, (self.bounds.size.width - bottomView.layer.bounds.size.width)/2), y: bottomView.layer.position.y)
                    }else {
                        if topView.layer.frame.origin.x + topView.layer.frame.size.width <= self.bounds.size.width / 2 {
                            print("左滑，切歌下一曲")
                            return
                        }
                        topView.layer.position = CGPoint.init(x: max(topView.layer.position.x + translation.x, (self.bounds.size.width - topView.layer.bounds.size.width)/2), y: topView.layer.position.y)
                        topViewMask.position = CGPoint.init(x: min(topViewMask.position.x - translation.x, topViewMask.bounds.size.width*3/2), y: topViewMask.position.y)
                        bottomView.layer.position = CGPoint.init(x: max(bottomView.layer.position.x + translation.x, (self.bounds.size.width - bottomView.layer.bounds.size.width)/2), y: bottomView.layer.position.y)
                    }
                    gesture.setTranslation(CGPoint.zero, in: self)
                }else{
                    //向右滑动
                    if isAnimated {
                        topView.layer.position = CGPoint.init(x: min(topView.layer.presentation()!.position.x + translation.x, (self.bounds.size.width + topView.layer.bounds.size.width)/2), y: topView.layer.position.y)
                        topViewMask.position = CGPoint.init(x: max(topViewMask.presentation()!.position.x - translation.x, topViewMask.bounds.size.width/2), y: topViewMask.position.y)
                        bottomView.layer.position = CGPoint.init(x: min(bottomView.layer.presentation()!.position.x + translation.x, (self.bounds.size.width + bottomView.layer.bounds.size.width)/2), y: bottomView.layer.position.y)
                    }else {
                        if topView.layer.frame.origin.x >= self.bounds.size.width / 2 {
                            print("右滑，切歌上一曲")
                            return
                        }
                        topView.layer.position = CGPoint.init(x: min(topView.layer.position.x + translation.x, (self.bounds.size.width + topView.layer.bounds.size.width)/2), y: topView.layer.position.y)
                        topViewMask.position = CGPoint.init(x: max(topViewMask.position.x - translation.x, topViewMask.bounds.size.width/2), y: topViewMask.position.y)
                        bottomView.layer.position = CGPoint.init(x: min(bottomView.layer.position.x + translation.x, (self.bounds.size.width + bottomView.layer.bounds.size.width)/2), y: bottomView.layer.position.y)
                    }
                    gesture.setTranslation(CGPoint.zero, in: self)
                }
                removeAnimate()
                scrollTimeLineWhetherNotice(notice: false)
            }
        }
        if gesture.state == .ended {
            //考虑到歌曲存在缓冲，请手动调用play方法
//            play()
            scrollTimeLineWhetherNotice(notice: true)
        }
    }
    
    private func scrollTimeLineWhetherNotice(notice: Bool) {
        let delta = (self.bounds.size.width + self.topView.bounds.size.width)/2 - self.topView.layer.position.x
        timeLine.text = "\(convertTime(Int(round(delta / 3))))/\(convertTime(topView.amplitudes.count/2))"
        if delegate != nil && notice {
            delegate?.didScrollToTime(time: NSInteger(round(delta / 3)))
        }
    }
    
    private func removeAnimate() {
        if isAnimated {
            isAnimated = false
            topView.layer.removeAnimation(forKey: "pan")
            topViewMask.removeAnimation(forKey: "pan")
            bottomView.layer.removeAnimation(forKey: "pan")
        }
    }
    
    private func keyframeAnimationFrom(_ start: CGFloat, to end: CGFloat, isTop:Bool) -> CAAnimation {
        let animation = CAKeyframeAnimation.init(keyPath: "position.x")
        let scale = UIScreen.main.scale
        let increment = copysign(1, end - start) / scale
        let numberOfSteps = Int(abs((end - start) / increment))
        let positions = NSMutableArray.init(capacity: numberOfSteps)
        for i in 0..<numberOfSteps {
            positions.add(start + CGFloat(i) * increment)
        }
        animation.values = (positions as! [Any])
        animation.calculationMode = .discrete
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        animation.duration = Double(Int(abs(end-start) / (waveWidth + waveSpace)))
        animation.delegate = self
        
        return animation
    }
    
    func animationDidStart(_ anim: CAAnimation) {
        if anim == topView.layer.animation(forKey: "pan") {
            
        }
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if isAnimated {
            topView.layer.position = topView.layer.presentation()!.position
            topView.layer.removeAllAnimations()
            topViewMask.position = topViewMask.presentation()!.position
            topViewMask.removeAllAnimations()
            bottomView.layer.position = bottomView.layer.presentation()!.position
            bottomView.layer.removeAllAnimations()
            isAnimated = false
        }
        if animationTimer.isValid {
            animationTimer.invalidate()
        }
    }
    
    deinit {
        
    }
}

class WaveformView: UIView {

    var isHighlight = false
    var amplitudes = [Double]()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(frame: CGRect, amplitudes: [Double], isHighlight: Bool) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.isOpaque = true
        self.amplitudes = amplitudes
        self.isHighlight = isHighlight
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        for i in 0..<amplitudes.count {
            if i%2 == 0 {
                //单数
                let path = CGMutablePath()
                let height = downMaxHeight * CGFloat(abs(amplitudes[i]))
                path.addRoundedRect(in: CGRect.init(x: CGFloat(Int(i/2)) * (waveWidth + waveSpace), y: 62, width: 2.5, height: height), cornerWidth: 1.25, cornerHeight: 1.25 >= height/2.0 ? 0 : 1.25)
                context.addPath(path)
                if isHighlight {
                    context.setFillColor(highlightAlphaColor.cgColor)
                }else {
                    context.setFillColor(normalAlphaColor.cgColor)
                }
                context.fillPath()
            }else {
                //双数
                let path = CGMutablePath()
                let height = upMaxHeight * CGFloat(abs(amplitudes[i]))
                path.addRoundedRect(in: CGRect.init(x: CGFloat(Int(i/2)) * (waveWidth + waveSpace), y: 60 - height, width: 2.5, height: height), cornerWidth: 1.25, cornerHeight: 1.25 >= height/2.0 ? 0 : 1.25)
                context.addPath(path)
                if isHighlight {
                    context.setFillColor(highlightColor.cgColor)
                }else {
                    context.setFillColor(normalColor.cgColor)
                }
                context.fillPath()
            }
        }
    }
}


