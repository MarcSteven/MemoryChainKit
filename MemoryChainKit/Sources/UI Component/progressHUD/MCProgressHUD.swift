//
//  MCProgressHUD.swift
//  MemoryChainUIKit
//
//  Created by Marc Zhao on 2018/9/16.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore



open class MCProgressHUD:UIView {
    
    
    //Properperties
    var activeView:UIView!
    let rotatorImageLayer:CALayer  = CALayer()
    let replicatorCircleLayer = CAReplicatorLayer()
    var circle  = CALayer()
    var shapeLayerForCroc  = CAShapeLayer()
    var animationDuration:Double = 2.5
    init(crocImageName:String) {
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        
        super.init(frame: frame)
        
        
        let backgroundImageView = UIImageView()
        backgroundImageView.frame = frame
        backgroundImageView.contentMode = .scaleToFill
        backgroundImageView.clipsToBounds = true
        backgroundImageView.backgroundColor = UIColor.clear
        addSubview(backgroundImageView)
        
        replicatorCircleLayer.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        let dotLenghth:CGFloat = 12
        let refreshRadius:CGFloat = 40
        circle.frame = CGRect(x: frame.size.width / 2 - refreshRadius, y: frame.size.height / 2 - refreshRadius, width: dotLenghth, height: dotLenghth)
        circle.backgroundColor = UIColor.darkGray.cgColor
        circle.cornerRadius = dotLenghth / 2
        
        let instanceCount = 12
        
        let fadeOut = CABasicAnimation(keyPath: "opacity")
        fadeOut.fromValue = 0.3
        fadeOut.toValue = 1.0
        fadeOut.duration = animationDuration
        
        fadeOut.repeatCount = Float.greatestFiniteMagnitude
        circle.add(fadeOut, forKey: nil)
        
        
        replicatorCircleLayer.instanceDelay = fadeOut.duration / CFTimeInterval(instanceCount)
        //replicatorCircleLayer.instanceDelay = fadeOut.duration / (TimeInterval)instanceCount
        replicatorCircleLayer.addSublayer(circle)
        replicatorCircleLayer.instanceCount = instanceCount
        
        let angle = -CGFloat.pi * 2 / CGFloat(instanceCount)
        replicatorCircleLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1)
        replicatorCircleLayer.backgroundColor = UIColor.clear.cgColor
        layer.addSublayer(replicatorCircleLayer)
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.width / 2, y: frame.height / 2), radius: refreshRadius + dotLenghth - 2 , startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
     
        
        shapeLayerForCroc.path = circlePath.cgPath
        shapeLayerForCroc.fillColor = UIColor.clear.cgColor
        layer.addSublayer(shapeLayerForCroc)
        
        
        let airPlaneImage = UIImageView()
        airPlaneImage.image = UIImage(named: "")
        rotatorImageLayer.contents = airPlaneImage.image?.cgImage
        rotatorImageLayer.frame = CGRect(x: 0, y: 0, width: airPlaneImage.image!.size.width, height: airPlaneImage.image!.size.height)
        rotatorImageLayer.opacity = 1.0
        rotatorImageLayer.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        rotatorImageLayer.backgroundColor = UIColor.clear.cgColor
        layer.addSublayer(rotatorImageLayer)
        
        let label = MCLabel(frame: CGRect(x: 0, y: (frame.size.height / 2) - (dotLenghth / 2), width: frame.size.width, height: 24))
        label.text = NSLocalizedString("Loading", comment: "")
        backgroundImageView.addSubview(label)
    }
    
    
    //MARK: - init method
    override public init(frame: CGRect) {
        super.init(frame:frame)
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    public func showHUD(onView  view:UIView) {
        startRefresh()
        activeView = view
        activeView.addSubview(self)
        activeView.layer.opacity = 0.5
        activeView.isUserInteractionEnabled = false 
    }
    public func hideHUD() {
        endRefresh()
    }
    
    private func startRefresh() {
        let crocAnimationPostion = CAKeyframeAnimation(keyPath: "position")
        crocAnimationPostion.path = shapeLayerForCroc.path
        crocAnimationPostion.calculationMode = kCAAnimationLinear
        
        let croOrientationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        croOrientationAnimation.fromValue = 0
        croOrientationAnimation.toValue = 2.0 * .pi
        
        
        let crocAnimation = CAAnimationGroup()
        
        crocAnimation.duration = animationDuration
        crocAnimation.repeatDuration = .infinity
        crocAnimation.animations = [crocAnimationPostion,croOrientationAnimation]
        rotatorImageLayer.add(crocAnimation, forKey: nil)
        
    }
    private  func endRefresh() {
        activeView.layer.opacity = 1.0
        activeView.isUserInteractionEnabled = true
        removeFromSuperview()
    }
    
}
