//
//  LinearProgressBar.swift
//  MemoryChainUIKit
//
//  Created by Marc Zhao on 2018/9/16.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit

//MARK: - Line progress bar 
open class LinearProgressBar:UIView, UIGestureRecognizerDelegate {
    //背景区域的颜色和透明度
    var backgroundColor1:UIColor  = UIColor(named: "4A4A4A")!
    //进度条view
    var progressView: UIView =  UIView()
    //提示按钮
    var hintBtn: UIButton!
    var beforeValue :CGFloat = 0 //前一个值
    var displayLink: CADisplayLink! //定时器 承接控制器里的定时器，删除view时保证定时器关闭
    var path: UIBezierPath!
    var progressLayer :CAShapeLayer!
    
    //初始化视图
    func initPopBackGroundView() -> LinearProgressBar {
        self.backgroundColor = backgroundColor1
        let tap:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(tapBtnAndcancelBtnClick))
        tap.delegate = self
        self.addGestureRecognizer(tap)
        return self
    }
    //弹出View
    func addAnimate(view:LinearProgressBar) {
        self.addProgressView()
    }
    //添加进度条
    func addProgressView() {
        progressView = UIView()
//        progressView.layer.masksToBounds = true
//        progressView.layer.cornerRadius = 7.5
        progressView.backgroundColor = backgroundColor1
        self.addSubview(progressView)
        
//        progressView.snp.makeConstraints { make in
//            make.left.right.top.bottom.equalTo(0)
//        }
        hintBtn = UIButton.init(type: UIButton.ButtonType.custom)
        hintBtn.setBackgroundImage(UIImage.init(named: "progressHint"), for: UIControl.State.normal)
        hintBtn.setTitle("", for: UIControl.State.normal)
        hintBtn.titleLabel?.font = UIFont.init(name: "", size: 14)
        hintBtn.contentHorizontalAlignment = .left
        hintBtn.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.addSubview(hintBtn)
//        hintBtn.snp.makeConstraints { make in
//            make.left.equalTo(getWidth(0))
//            make.top.equalTo(progressView.snp.bottom).offset(getHeight(10))
//            make.width.equalTo(getWidth(30))
//            make.height.equalTo(getHeight(20))
//        }
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.gradentWith(frame: self.progressView.frame)
        }
    }
    
    
    
    //为进度条添加遮罩，及layer
    @objc func gradentWith(frame:CGRect) {
        path = UIBezierPath.init()
        path.stroke()//添加遮罩
        progressLayer = CAShapeLayer.init()
        progressLayer.frame = progressView.bounds
        progressLayer.strokeColor = UIColor.darkGray.cgColor
        progressLayer.lineCap =  CAShapeLayerLineCap.init(rawValue: "kCALineCapRound")
        progressLayer.lineWidth = progressView.frame.size.height //渐变图层
        let grain:CALayer = CALayer.init()
        let gradientLayer: CAGradientLayer = CAGradientLayer.init()
        /*let fixColor: UIColor = .blue ============== 渐变效果
        let preColor: UIColor = allColor.mainColor.value
        gradientLayer.colors = [preColor.cgColor,fixColor.cgColor] */ 
        gradientLayer.frame = CGRect.init(x: 0, y: 0, width: progressView.frame.size.width, height: progressView.frame.size.height)

        gradientLayer.backgroundColor = UIColor.darkGray.cgColor        // 开始点
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
        // 结束点
        gradientLayer.endPoint = CGPoint.init(x: 1, y: 1)
        grain.addSublayer(gradientLayer)
        grain.mask = progressLayer
        progressView.layer.addSublayer(grain)//增加动画
        let pathAnimation : CABasicAnimation = CABasicAnimation.init(keyPath: "strokeEnd")
        pathAnimation.duration = 0;
        pathAnimation.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName(rawValue: "linear"))
        pathAnimation.fromValue = NSNumber.init(value: 0.0)
        pathAnimation.toValue = NSNumber.init(value: 1.0)
        pathAnimation.autoreverses = false
        pathAnimation.repeatCount = 1
        progressLayer.add(pathAnimation, forKey: "strokeEndAnimation")
    }
    fileprivate func getHeight(_ height:CGFloat)->CGFloat {
        return UIScreen.main.bounds.size.height / height * 736
    }
    fileprivate func getWidth(_ width:CGFloat)->CGFloat {
        return UIScreen.main.bounds.size.width / width / 414
    }
    //当前进度
    func passValue(currentValue: CGFloat,allValue: CGFloat) {
        if currentValue < allValue {
            //当前比例
            let currentProportion : CGFloat = currentValue/allValue
            hintBtn.frame = CGRect.init(x: 0 + currentProportion * progressView.frame.size.width, y: progressView.frame.minY + getHeight(10), width: getWidth(30), height: getHeight(20))
            hintBtn.setTitle("\(NSInteger(currentProportion*100))%", for: UIControl.State.normal)
            if currentValue == 0.0 {
                hintBtn.setTitle("", for: .normal)
                beforeValue = 0.0
                path = UIBezierPath.init()
                path.stroke()//添加遮罩
                progressLayer.path = path.cgPath
                return
            }
            path.move(to: CGPoint.init(x: progressView.frame.size.width * (beforeValue/allValue), y: progressView.frame.size.height/2))
            path.addLine(to: CGPoint.init(x: progressView.frame.size.width * currentProportion, y: progressView.frame.size.height/2))
            progressLayer.path = path.cgPath
        }
        else{
            //上传/下载成功 隐藏当前状态
            self.tapBtnAndcancelBtnClick()
        }
        beforeValue = currentValue
    }
    //移除或者中断进度
    @objc func tapBtnAndcancelBtnClick() {
//        self.removeFromSuperview()
//        displayLink.invalidate()
//        displayLink = nil
    }
    
//    //MARK: - properties
//    fileprivate var screenSize:CGRect = UIScreen.main.bounds
//
//    fileprivate var isAnimationRunning:Bool = false
//    fileprivate var progressBarIndicator:UIView!
//    open var backgroundProgressBarColor:UIColor = UIColor(red: 0.73, green: 0.87, blue: 0.98, alpha: 1.0)
//    open var progressBarColor:UIColor = UIColor(red: 0.12, green: 0.53, blue: 0.90, alpha: 1.0)
//    open var linearBarHeight:CGFloat = 5
//    open var linearBarWidth:CGFloat = 5
//    //MARK: - init
//    public init() {
//        super.init(frame: CGRect(origin: CGPoint(x: 0, y: 20), size: CGSize(width: screenSize.width, height: 0)))
//        self.progressBarIndicator = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 0, height: linearBarHeight))
//        )
//    }
//    override public init(frame: CGRect) {
//        super.init(frame: frame)
//        self.progressBarIndicator = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 0, height: linearBarHeight)))
//
//    }
//    public required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//    override open func layoutSubviews() {
//        super.layoutSubviews()
//        self.screenSize = UIScreen.main.bounds
//        if linearBarWidth == 0 || linearBarWidth == self.screenSize.height {
//            linearBarWidth = self.screenSize.width
//
//        }
//
//        if UIDeviceOrientation.isLandscape(UIDevice.current.orientation) {
//            self.frame = CGRect(origin: CGPoint(x: self.frame.origin.x, y: self.frame.origin.y), size: CGSize(width: linearBarWidth, height: self.frame.height))
//
//        }
//        if UIDeviceOrientationIsPortrait(UIDevice.current.orientation) {
//            self.frame = CGRect(origin: CGPoint(x: self.frame.origin.x, y: self.frame.origin.y), size: CGSize(width: linearBarWidth, height: self.frame.height))
//        }
//    }
//    //MARK： - public function
//    open func startAnimation() {
//        configureColors()
//        show()
//        if !isAnimationRunning {
//            self.isAnimationRunning = true
//            UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [], animations: {
//                self.frame = CGRect(x: 0, y: self.frame.origin.y, width: self.linearBarWidth, height: self.linearBarHeight)
//            }) { (animationFinished) in
//                self.addSubview(self.progressBarIndicator)
//                self.configureAnimation()
//            }
//        }
//
//
//    }
//    fileprivate func show() {
//        if self.superview != nil {
//            return
//        }
//        if let topController = getTopViewController() {
//            let superView:UIView = topController.view
//            superView.addSubview(self)
//        }
//    }
//    open func stopAnimation() {
//        self.isAnimationRunning = false
//        UIView.animate(withDuration: 0.5) {
//            self.progressBarIndicator.frame = CGRect(x: 0, y: 0, width: self.linearBarWidth, height: 0)
//        }
//    }
//    fileprivate func configureColors() {
//        self.backgroundColor = self.backgroundProgressBarColor
//        self.progressBarIndicator.backgroundColor = self.progressBarColor
//        self.layoutIfNeeded()
//
//    }
//    fileprivate func configureAnimation() {
//        guard let superView = self.superview else {
//            stopAnimation()
//            return
//        }
//        self.progressBarIndicator.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 0, height: linearBarHeight))
//        UIView.animateKeyframes(withDuration: 1.0, delay: 0, options: [], animations: {
//            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
//                self.progressBarIndicator.frame = CGRect(x: 0, y: 0, width: self.linearBarWidth * 0.7, height: self.linearBarHeight)
//            })
//            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
//                self.progressBarIndicator.frame = CGRect(x: superView?.frame.width, y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>)
//                self.progressBarIndicator.frame = CGRect(x: superview?.frame.width ?? <#default value#>, y: 0, width: 0, height: self.linearBarHeight)
//            })
//
//        }) { (completed) in
//            if self.isAnimationRunning {
//                self.configureAnimation()
//            }
//        }
//    }
//    fileprivate func getTopViewController() ->UIViewController? {
//        var topViewController:UIViewController? = UIApplication.shared.keyWindow?.rootViewController
//        while topViewController?.presentedViewController != nil {
//            topViewController = topViewController?.presentedViewController
//        }
//        return topViewController
//
//    }
}
