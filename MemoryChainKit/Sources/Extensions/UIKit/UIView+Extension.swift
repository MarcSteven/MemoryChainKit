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
public extension UIView {
    func firstAncestor<T>(ofType type: T.Type) -> T? {
        guard let superview = superview else {
            return nil
        }

        return superview as? T ?? superview.firstAncestor(ofType: type)
    }
}
//MARK: - blur
extension UIView {
    
    private struct AssociatedKeys {
        static var descriptiveName = "AssociatedKeys.DescriptiveName.blurView"
    }
    
    private (set) var blurView: BlurView {
        get {
            if let blurView = objc_getAssociatedObject(
                self,
                &AssociatedKeys.descriptiveName
                ) as? BlurView {
                return blurView
            }
            self.blurView = BlurView(to: self)
            return self.blurView
        }
        set(blurView) {
            objc_setAssociatedObject(
                self,
                &AssociatedKeys.descriptiveName,
                blurView,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    class BlurView {
        
        private var superview: UIView
        private var blur: UIVisualEffectView?
        private var editing: Bool = false
        private (set) var blurContentView: UIView?
        private (set) var vibrancyContentView: UIView?
        
        var animationDuration: TimeInterval = 0.1
        
        /**
         * Blur style. After it is changed all subviews on
         * blurContentView & vibrancyContentView will be deleted.
         */
        var style: UIBlurEffect.Style = .light {
            didSet {
                guard oldValue != style,
                    !editing else { return }
                applyBlurEffect()
            }
        }
        /**
         * Alpha component of view. It can be changed freely.
         */
        var alpha: CGFloat = 0 {
            didSet {
                guard !editing else { return }
                if blur == nil {
                    applyBlurEffect()
                }
                let alpha = self.alpha
                UIView.animate(withDuration: animationDuration) {
                    self.blur?.alpha = alpha
                }
            }
        }
        
        init(to view: UIView) {
            self.superview = view
        }
        
        func setup(style: UIBlurEffect.Style, alpha: CGFloat) -> Self {
            self.editing = true
            
            self.style = style
            self.alpha = alpha
            
            self.editing = false
            
            return self
        }
        
        func enable(isHidden: Bool = false) {
            if blur == nil {
                applyBlurEffect()
            }
            
            self.blur?.isHidden = isHidden
        }
        
        private func applyBlurEffect() {
            blur?.removeFromSuperview()
            
            applyBlurEffect(
                style: style,
                blurAlpha: alpha
            )
        }
        
        private func applyBlurEffect(style: UIBlurEffect.Style,
                                     blurAlpha: CGFloat) {
            superview.backgroundColor = UIColor.clear
            
            let blurEffect = UIBlurEffect(style: style)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            
            let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
            let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
            blurEffectView.contentView.addSubview(vibrancyView)
            
            blurEffectView.alpha = blurAlpha
            
            superview.insertSubview(blurEffectView, at: 0)
            
            blurEffectView.addAlignedConstrains()
            vibrancyView.addAlignedConstrains()
            
            self.blur = blurEffectView
            self.blurContentView = blurEffectView.contentView
            self.vibrancyContentView = vibrancyView.contentView
        }
    }
    
    private func addAlignedConstrains() {
        translatesAutoresizingMaskIntoConstraints = false
        addAlignConstraintToSuperview(attribute: NSLayoutConstraint.Attribute.top)
        addAlignConstraintToSuperview(attribute: NSLayoutConstraint.Attribute.leading)
        addAlignConstraintToSuperview(attribute: NSLayoutConstraint.Attribute.trailing)
        addAlignConstraintToSuperview(attribute: NSLayoutConstraint.Attribute.bottom)
    }
    
    private func addAlignConstraintToSuperview(attribute: NSLayoutConstraint.Attribute) {
        superview?.addConstraint(
            NSLayoutConstraint(
                item: self,
                attribute: attribute,
                relatedBy: NSLayoutConstraint.Relation.equal,
                toItem: superview,
                attribute: attribute,
                multiplier: 1,
                constant: 0
            )
        )
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

public extension UIView {
  
  func pinEdgesToSuperview() {
    translatesAutoresizingMaskIntoConstraints = false
    guard let superview = self.superview else { return }
    let constraints = NSLayoutConstraint.pinningEdgesToSuperview(view: self)
    superview.addConstraints(constraints)
  }
  
  func pinToSuperview(forAtrributes attributes: [NSLayoutConstraint.Attribute], multiplier: CGFloat = 1.0, constant: CGFloat = 0.0) {
    translatesAutoresizingMaskIntoConstraints = false
    guard let superview = self.superview else { return }
    let constraints = NSLayoutConstraint.pinningToSuperview(view: self, attributes: attributes, multiplier: multiplier, constant: constant)
    superview.addConstraints(constraints)
  }
  
  func pin(toView: UIView, attributes: [NSLayoutConstraint.Attribute], multiplier: CGFloat = 1.0, constant: CGFloat = 0.0) {
    translatesAutoresizingMaskIntoConstraints = false
    guard let superview = self.superview else { return }
    let constraints = NSLayoutConstraint.pinning(view: self, toView: toView, attributes: attributes, multiplier: multiplier, constant: constant)
    superview.addConstraints(constraints)
  }
  
  func pin(attribute: NSLayoutConstraint.Attribute, toView: UIView?, toAttribute: NSLayoutConstraint.Attribute, multiplier: CGFloat = 1.0, constant: CGFloat = 0.0) {
    translatesAutoresizingMaskIntoConstraints = false
    guard let superview = self.superview else { return }
    let constraint = NSLayoutConstraint.pinning(view: self, attribute: attribute, toView: toView, toAttribute: toAttribute, multiplier: multiplier, constant: constant)
    superview.addConstraint(constraint)
  }
}
public extension UIView {
    var cornerRadius:CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds  = newValue > 0
        }
    }
}



