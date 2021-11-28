//
//  UIViewExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/10/16.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import UIKit
import ObjectiveC
import WebKit


public extension UIView {
    func keyWindow() ->UIWindow? {
        for window in UIApplication.shared.windows {
            if window.isKeyWindow {
                return window
            }
        }
        return UIWindow()
    }
    func safeAreaTop() ->CGFloat {
        if #available(iOS 11.0, *) {
            return keyWindow()?.safeAreaInsets.top ?? 0.0
        }
        return 0
    }
    func safeAreaBottom() ->CGFloat {
        if #available(iOS 11.0, *) {
            return keyWindow()?.safeAreaInsets.bottom ?? 0.0
        }
        return 0
    }
}


public extension UIView {
    func addSubviews(_  views:[UIView]) {
        for view in views {
            addSubview(view)
        }
    }
}

public extension UIView {
    func hasSuperview(_ superview: UIView) -> Bool{
        return viewHasSuperview(self, superview: superview)
    }
    
    fileprivate func viewHasSuperview(_ view: UIView, superview: UIView) -> Bool {
        if let sview = view.superview {
            if sview === superview {
                return true
            } else{
                return viewHasSuperview(sview, superview: superview)
            }
        } else{
            return false
        }
    }
}
public extension UIView {
    /// add corner radius fo UIView 
    func addCornerRadiusAnimation(_ from:CGFloat,
                                  to:CGFloat,
                                  duration:CFTimeInterval) {
        let animation = CABasicAnimation(keyPath: "cornerRadius")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.fromValue = from
        animation.toValue = to
        animation.duration = duration
        self.layer.add(animation, forKey: "cornerRadius")
        self.layer.cornerRadius = to
        
    }

}
public extension UIView {
    func createImage() ->UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width:self.frame.width,height: self.frame.height), true, 1)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
public  extension UIView {
    func pinToSafeArea(top: CGFloat? = 0, left: CGFloat? = 0, bottom: CGFloat? = 0, right: CGFloat? = 0){
            guard let superview = self.superview else { return }
            
            prepareForAutoLayout()
            
            var guide: UILayoutGuide
            if #available(iOS 11.0, *) {
                guide = superview.safeAreaLayoutGuide
            } else {
                guide = superview.layoutMarginsGuide
            }
            
            if let top = top {
                self.topAnchor.constraint(equalTo: guide.topAnchor, constant: top).isActive = true
            }
            
            if let bottom = bottom {
                self.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: bottom).isActive = true
            }
            
            if let left = left {
                self.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: left).isActive = true
            }
            
            if let right = right {
                self.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: right).isActive = true
            }
        }
        
        func pinToSuperView(top: CGFloat? = 0, left: CGFloat? = 0, bottom: CGFloat? = 0, right: CGFloat? = 0){
            guard let superview = self.superview else { return }
            
            prepareForAutoLayout()
            
            if let top = top {
                self.topAnchor.constraint(equalTo: superview.topAnchor, constant: top).isActive = true
            }
            
            if let bottom = bottom {
                self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: bottom).isActive = true
            }
            
            if let left = left {
                self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: left).isActive = true
            }
            
            if let right = right {
                self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: right).isActive = true
            }
        }
        
        func centerInSuperView(){
            guard let superview = self.superview else { return }
            
            prepareForAutoLayout()
            
            self.centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
            self.centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
        }
        
        func constraint(width: CGFloat){
            prepareForAutoLayout()
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        func constraint(height: CGFloat){
            prepareForAutoLayout()
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        func makeWidthEqualHeight(){
            prepareForAutoLayout()
            self.widthAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        }
        
        func prepareForAutoLayout(){
            translatesAutoresizingMaskIntoConstraints = false
        }
}
public extension UIView {
    /// Performs a view animation using a timing curve corresponding to the motion of a physical spring.
    ///
    /// - Parameters:
    ///   - duration:   The total duration of the animations, measured in seconds. If you specify a negative value or `0`, the changes are made without animating them. The default value is `0.6`.
    ///   - delay:      The amount of time (measured in seconds) to wait before beginning the animations. The default value is `0`.
    ///   - damping:    The damping ratio for the spring animation as it approaches its quiescent state. The default value is `0.7`.
    ///   - velocity:   The initial spring velocity. For smooth start to the animation, match this value to the view’s velocity as it was prior to attachment. The default value is `0`.
    ///   - options:    A mask of options indicating how you want to perform the animations. The default value is `UIViewAnimationOptions.AllowUserInteraction`.
    ///   - animations: A block object containing the changes to commit to the views.
    ///   - completion: A block object to be executed when the animation sequence ends.
     static func animate(_ duration: TimeInterval = 0.6, delay: TimeInterval = 0, damping: CGFloat = 0.7, velocity: CGFloat = 0, options: AnimationOptions = .allowUserInteraction, animations: @escaping (() -> Void), completion: ((Bool) -> Void)?) {
        UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: options, animations: animations, completion: completion)
    }

    /// Performs a view animation using a timing curve corresponding to the motion of a physical spring.
    ///
    /// - Parameters:
    ///   - duration:   The total duration of the animations, measured in seconds. If you specify a negative value or `0`, the changes are made without animating them. The default value is `0.6`.
    ///   - delay:      The amount of time (measured in seconds) to wait before beginning the animations. The default value is `0`.
    ///   - damping:    The damping ratio for the spring animation as it approaches its quiescent state. The default value is `0.7`.
    ///   - velocity:   The initial spring velocity. For smooth start to the animation, match this value to the view’s velocity as it was prior to attachment. The default value is `0`.
    ///   - options:    A mask of options indicating how you want to perform the animations. The default value is `UIViewAnimationOptions.AllowUserInteraction`.
    ///   - animations: A block object containing the changes to commit to the views.
     static func animate(_ duration: TimeInterval = 0.6, delay: TimeInterval = 0, damping: CGFloat = 0.7, velocity: CGFloat = 0, options: AnimationOptions = .allowUserInteraction, animations: @escaping (() -> Void)) {
        UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: options, animations: animations, completion: nil)
    }

    static func animateFromCurrentState(withDuration duration: TimeInterval = 0.25, _ animations: @escaping () -> Void) {
        animateFromCurrentState(withDuration: duration, animations: animations) {}
    }

    static func animateFromCurrentState(withDuration duration: TimeInterval = 0.25, animations: @escaping () -> Void, completion: @escaping () -> Void) {
        UIView.animate(withDuration: duration, delay: 0, options: .beginFromCurrentState, animations: {
            animations()
        }, completion: { _ in
            completion()
        })
    }
}

// MARK: - Transition

@objc extension UIView {
    /// Creates a transition animation for the receiver.
    public func transition(
        duration: TimeInterval,
        options: UIView.AnimationOptions = [.transitionCrossDissolve],
        animations: @escaping () -> Void
    ) {
        var options = options
        options.insert(.allowAnimatedContent)
        options.insert(.allowUserInteraction)

        UIView.transition(with: self, duration: duration, options: options, animations: {
            animations()
        }, completion: nil)
    }

    /// Creates a transition animation for the receiver.
    public func transition(
        duration: TimeInterval,
        options: UIView.AnimationOptions = [.transitionCrossDissolve],
        animations: @escaping () -> Void,
        completion: @escaping () -> Void
    ) {
        var options = options
        options.insert(.allowAnimatedContent)
        options.insert(.allowUserInteraction)

        UIView.transition(with: self, duration: duration, options: options, animations: {
            animations()
        }, completion: { _ in
            completion()
        })
    }
}

extension UIView {
    @objc open func setHidden(
        _ hide: Bool,
        animated: Bool,
        duration: TimeInterval = 0.25,
        _ completion: (() -> Void)? = nil
    ) {
        guard animated else {
            isHidden = hide
            completion?()
            return
        }

        UIView.transition(
            with: self,
            duration: duration,
            options: [.beginFromCurrentState, .transitionCrossDissolve],
            animations: {
                self.isHidden = hide
            },
            completion: { _ in
                completion?()
            }
        )
    }

    @objc open func setAlpha(
        _ value: CGFloat,
        animated: Bool = false,
        duration: TimeInterval = 0.25,
        options: AnimationOptions = [.curveEaseInOut],
        completion: (() -> Void)? = nil
    ) {
        UIView.animate(animated ? duration : 0, options: options, animations: {
            self.alpha = value
        }, completion: { _ in
            completion?()
        })
    }
}

// MARK: - BackgroundColor

// MARK: - Rotating

extension UIView {
    @objc open func stopRotating() {
        let animationKey = "xcore.rotation"

        guard layer.animation(forKey: animationKey) != nil else {
            return
        }

        layer.removeAnimation(forKey: animationKey)
    }
}

public extension UIView {
    func allConstraints() -> [AnyHashable]? {
        var array: [AnyHashable] = []
        array.append(contentsOf: constraints)
        for view in subviews {
            if let all = view.allConstraints() {
                array.append(contentsOf: all)
            }
        }
        return array
    }
}

extension NSObjectProtocol where Self: UIButton {
    /// Temporarily set the text.
    ///
    /// - Parameters:
    ///   - temporaryText: The text to set temporarily.
    ///   - interval: The interval after the given temporary text is removed.
    public func setTemporaryText(_ temporaryText: String?, removeAfter interval: TimeInterval = 1) {
        let originalText = text
        let originalUserInteraction = isUserInteractionEnabled

        text = temporaryText
        isUserInteractionEnabled = false

        DispatchQueue.main.asyncAfter(deadline: .now() + interval) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.text = originalText
            strongSelf.isUserInteractionEnabled = originalUserInteraction
        }
    }
}

public extension UIView {
    var height:CGFloat {
        get {
            return frame.size.height
        }
        set {
            frame.size.height = newValue
        }
    }
    var width:CGFloat {
        get {
            return frame.size.width
        }
        set {
            frame.size.width = newValue
        }
    }
    var centerY:CGFloat {
        get {
            return center.y
        }
        set {
            center.y = newValue
            
        }
    }
    
    var centerX:CGFloat {
        get {
            return center.x
        }
        set {
            center.x = newValue
        }
    }
    var top:CGFloat {
        get {
            return self.frame.origin.y
        }
    }
    func orientationWidth() -> CGFloat {
        return UIApplication.shared.statusBarOrientation.isLandscape
            ? height
            : width
    }
    func orientationHeight() ->CGFloat {
        return UIApplication.shared.statusBarOrientation.isLandscape ? width : height
    }
    /// Load Xib from name
    static func loadFrom<T: UIView>(nibNamed: String, bundle : Bundle? = nil) -> T? {
        let nib = UINib(nibName: nibNamed, bundle: bundle)
        return nib.instantiate(withOwner: nil, options: nil)[0] as? T
    }
    func getConstraint(byAttribute attr: NSLayoutConstraint.Attribute) -> NSLayoutConstraint? {
        return constraints.filter { $0.firstAttribute == attr }.first
    }
    
}
public extension UIView {
            func showToast(_ message: String?, duration: CGFloat) {
               let label = UILabel(frame: CGRect.zero)
               label.textColor = UIColor.white
               label.text = message
               label.backgroundColor = UIColor.black.withAlphaComponent(0.6)
               label.layer.cornerRadius = 10
               label.layer.masksToBounds = true
               label.textAlignment = .center
               label.font = UIFont.boldSystemFont(ofSize: 15)

               let width = label.intrinsicContentSize.width + 24
               let height = label.intrinsicContentSize.height + 16
               label.frame = CGRect(x: bounds.size.width / 2 - width / 2, y: bounds.size.height / 2 - height / 2, width: width, height: height)
                UIView.transition(
                    with: self,
                    duration: 0.3,
                    options: .transitionCrossDissolve,
                    animations: { [self] in
                        addSubview(label)
                    })

                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(Double(duration) * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
                    UIView.transition(
                        with: self,
                        duration: 0.3,
                        options: .transitionCrossDissolve,
                        animations: {
                            label.removeFromSuperview()
                        })

                })
            }

    }


public extension UIView {
    private struct AssoicateKey {
        static var isCapturing = "isCapturing"
    }
    var isCapturing:Bool! {
        get {
            let num = objc_getAssociatedObject(self, &AssoicateKey.isCapturing)
            if num == nil {
                return false
            }
            if let numObj = num as? NSNumber {
                return numObj.boolValue
            }else {
                return false
            }
        }
        set {
            let num = NSNumber(value: newValue as Bool)
            objc_setAssociatedObject(self, &AssoicateKey.isCapturing, num, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    func containsWKWebView() ->Bool {
        if self.isKind(of: WKWebView.self) {
            return true
        }
        for subview in self.subviews {
            if subview.containsWKWebView() {
                return true
            }
        }
        return false
    }
    func capture(_ completionHandle:@escaping ((_ capturedImage:UIImage?)->Void)) {
        self.isCapturing = true
        let bounds = self.bounds
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        
        context?.translateBy(x: -self.frame.origin.x, y: -self.frame.origin.y)
        if containsWKWebView() {
            self.drawHierarchy(in: bounds, afterScreenUpdates: true)
        }else {
            self.layer.render(in: context!)
        }
        let capturedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        context?.restoreGState()
        
        UIGraphicsEndImageContext()
        
        self.isCapturing = false
        completionHandle(capturedImage)
    }
}
