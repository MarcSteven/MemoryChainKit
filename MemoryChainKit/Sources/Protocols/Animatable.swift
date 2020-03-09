//
//  Animatable.swift
//  MemoryChain
//
//  Created by Marc Zhao on 2018/8/4.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit

/// Conform to `Animatable` protocol to animate views.
public protocol Animatable: AnyObject {}

// MARK: - Default implementation for UIView.
public extension Animatable where Self: UIView {
    
    /// Fade in view.
    ///
    /// - Parameters:
    ///   - duration: animation duration in seconds _(default is 1.0 second)_.
    ///   - delay: animation delay in seconds _(default is 0.0 second)_.
    ///   - completion: optional completion handler to run with animation finishes _(default is nil)_.
    func fadeIn(withDuration duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, delay: delay, options: [], animations: { [unowned self] in
            self.alpha = 1.0
            }, completion: completion)
    }
    
    /// Fade out view.
    ///
    /// - Parameters:
    ///   - duration: animation duration in seconds _(default is 1.0 second)_.
    ///   - delay: animation delay in seconds _(default is 0.0 second)_.
    ///   - completion: optional completion handler to run with animation finishes _(default is nil)_.
    func fadeOut(withDuration duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, delay: delay, options: [], animations: { [unowned self] in
            self.alpha = 0.0
            }, completion: completion)
    }
    
    /// Pop in view.
    ///
    /// - Parameters:
    ///   - duration: animation duration in seconds _(default is 0.25 second)_.
    ///   - delay: animation delay in seconds _(default is 0.0 second)_.
    ///   - completion: optional completion handler to run with animation finishes _(default is nil)_.
    func popIn(withDuration duration: TimeInterval = 0.25, delay: TimeInterval = 0.0, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, delay: delay, options: [], animations: { [unowned self] in
            self.transform = .init(scaleX: 0.95, y: 0.95)
            }, completion: completion)
    }
    
    /// Pop out view.
    ///
    /// - Parameters:
    ///   - duration: animation duration in seconds _(default is 0.25 second)_.
    ///   - delay: animation delay in seconds _(default is 0.0 second)_.
    ///   - completion: optional completion handler to run with animation finishes _(default is nil)_.
    func popOut(withDuration duration: TimeInterval = 0.25, delay: TimeInterval = 0.0, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, delay: delay, options: [], animations: { [unowned self] in
            self.transform = .identity
            }, completion: completion)
    }
    
    /// Shake view.
    ///
    /// - Parameters:
    ///   - duration: animation duration in seconds _(default is 1.0 second)_.
    ///   - delay: animation delay in seconds _(default is 0.0 second)_.
    ///   - completion: optional completion handler to run with animation finishes _(default is nil)_.
    func shake(withDuration duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: (() -> Void)? = nil) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [unowned self] in
            CATransaction.begin()
            let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
            CATransaction.setCompletionBlock(completion)
            animation.duration = duration
            animation.values = [-15.0, 15.0, -12.0, 12.0, -8.0, 8.0, -3.0, 3.0, 0.0]
            self.layer.add(animation, forKey: "shake")
            CATransaction.commit()
        }
    }
    
}
