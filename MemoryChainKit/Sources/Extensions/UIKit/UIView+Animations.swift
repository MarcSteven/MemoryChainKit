//
//  UIView+Animations.swift
//  MemoryChain
//
//  Created by Marc Zhao on 2018/8/22.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit

//MARK: -  animations about the view 

public extension UIView {
    func move(to destination:CGPoint,duration:TimeInterval,
              options:UIView.AnimationOptions) {
        UIView.animate(withDuration:duration,delay:0,options:options,animations:{
            self.center = destination
        },completion:nil)
    }
    func rotate180(duration: TimeInterval, options: UIView.AnimationOptions) {
        UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
            self.transform = self.transform.rotated(by: CGFloat.pi)
        }, completion: nil)
    }
    func addSubviewWithZoomInAnimation(_ view: UIView, duration: TimeInterval,
                                       options: UIView.AnimationOptions) {
        // 1
        view.transform = view.transform.scaledBy(x: 0.01, y: 0.01)
        
        // 2
        addSubview(view)
        
        UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
            // 3
            view.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    func removeWithZoomOutAnimation(duration: TimeInterval,
                                    options: UIView.AnimationOptions) {
        UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
            // 1
            self.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        }, completion: { _ in
            // 2
            self.removeFromSuperview()
        })
    }
    func addSubviewWithFadeAnimation(_ view: UIView, duration: TimeInterval, options: UIView.AnimationOptions) {
        // 1
        view.alpha = 0.0
        // 2
        addSubview(view)
        
        UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
            // 3
            view.alpha = 1.0
        }, completion: nil)
    }
    func changeColor(to color: UIColor, duration: TimeInterval,
                     options: UIView.AnimationOptions) {
        UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
            self.backgroundColor = color
        }, completion: nil)
    }
    @objc func removeWithSinkAnimationRotateTimer(timer: Timer) {
        // 1
        let newTransform = transform.scaledBy(x: 0.9, y: 0.9)
        // 2
        transform = newTransform.rotated(by: 0.314)
        // 3
        alpha *= 0.98
        // 4
        tag -= 1;
        // 5
        if tag <= 0 {
            timer.invalidate()
            removeFromSuperview()
        }
    }
}
extension UIView.AnimationCurve {
    var title:String {
        switch self {
        case .easeIn:
            return "Ease in"
        case .easeOut:
            return "Ease out"
        case .easeInOut:
            return "Ease In Out"
        case .linear:
            return "Linear"
        
        }
    }
    //convert this curve into it's correspoing uiviewAniamtionOptions value for use in Animations
    var animationOptions:UIView.AnimationOptions {
        switch self {
        case .easeIn:
            return .curveEaseIn
        case .easeInOut:
            return .curveEaseInOut
        case .linear:
            return .curveLinear
        case .easeOut:
            return .curveEaseOut
        }
    }
}
