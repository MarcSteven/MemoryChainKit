//
//  UIView+Extension.swift
//  MemoryChain
//
//  Created by Marc Zhao on 2018/8/5.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//
import UIKit

public extension UIView {
    func parentView<T:UIView>(of type:T.Type) ->T? {
        guard let view = superview else {
            return nil
        }
        return (view as? T) ?? view.parentView(of: T.self)
    }

}

public typealias GradientPoints = (startPoint:CGPoint,endPoint:CGPoint)
//Gradient orientation
public enum GradientOrientation {
    case topRightToBottomLeft,topLeftToBottomRight,horizontal,vertical
    var startPoint:CGPoint {
        return points.startPoint
    }
    var endPoint:CGPoint {
        return points.endPoint
    }
    var points:GradientPoints {
        get {
            switch self {
            case .topRightToBottomLeft:
                return (CGPoint(x: 0.0, y: 1.0),CGPoint(x: 1.0, y: 0.0))
            case .topLeftToBottomRight:
                return (CGPoint(x: 0.0, y: 0.0),CGPoint(x: 1, y: 1))
            case .horizontal:
                return (CGPoint(x: 0.0, y: 0.5),CGPoint(x: 1.0, y: 0.5))
            case .vertical:
                return (CGPoint(x: 0.0, y: 0.0),CGPoint(x: 0.0, y: 1.0))
           
            }
        }
    }
}
//MARK: - configure gradient to the view
public extension UIView {
    
    func configureGradient(withColours colours: [UIColor], locations: [NSNumber]? = nil) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func configureGradient(withColours colours: [UIColor], gradientOrientation orientation: GradientOrientation)  {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.startPoint = orientation.startPoint
        gradient.endPoint = orientation.endPoint
        self.layer.insertSublayer(gradient, at: 0)
    }
}
public extension UIView {
    func move(to destination:CGPoint,duration:TimeInterval,
              options:UIView.AnimationOptions) {
        UIView.animate(withDuration:duration,delay:0,options:options,animations:{
            self.center = destination
        },completion:nil)
    }
    func rotate360Degrees(duration:TimeInterval = 1.0,
                          completionDelegate:AnyObject? = nil) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 2.0)
        rotateAnimation.duration = duration
        if let delegate:AnyObject = completionDelegate {
            rotateAnimation.delegate = delegate as? CAAnimationDelegate
        }
        self.layer.add(rotateAnimation, forKey: nil)
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
public extension UIView.AnimationCurve {
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
        
        @unknown default:
            fatalError()
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
        @unknown default:
            fatalError()
        }
    }
}
extension UIView  {
open func printDebugSubviewsDescription() {
    debugSubviews()
}

private func debugSubviews(_ count: Int = 0) {
    if count == 0 {
        print("\n\n\n")
    }

    for _ in 0...count {
        print("--")
    }

    print("\(type(of: self))")

    for view in subviews {
        view.debugSubviews(count + 1)
    }

    if count == 0 {
        print("\n\n\n")
    }
}
}
