//
//  UITabBarExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/17.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import UIKit


extension UITabBar {
    private struct AssociatedKey {
        static var isTransparent = "isTransparent"
        static var borderWidth = "borderWidth"
    }
    open var isTransparent:Bool {
        get {
            ((getAssociated(associatedKey: &AssociatedKey.isTransparent) ) != nil)
        }
        set {
            guard newValue != isTransparent  else {
                return
            }
            setAssociated(value: newValue, associatedKey: &AssociatedKey.isTransparent)
            guard newValue else {
                backgroundImage = nil
                return
            }
            backgroundImage = UIImage()
            shadowImage = UIImage()
            isTranslucent = true
            backgroundColor = .clear
    }
        
}
    open var isBorderHidden:Bool {
        get {
            return value(forKey: "_hidesShadow") as? Bool ?? false
        }
        set {
            setValue(newValue, forKey: "_hidesShadow")
        }
        
    }
    @objc dynamic open override var borderWidth: CGFloat {
        get {
            objc_getAssociatedObject(self, &AssociatedKey.borderWidth) as! CGFloat
            
        }
        set {
            setAssociated(value: newValue, associatedKey: &AssociatedKey.borderWidth)
            
        }
    }
        private var topBorderView:UIView {
        let tag = "topBorderView".hashValue
        if let view = viewWithTag(tag) {
            return view
        }
        setBorder(color: borderColor ?? .clear, thickness: borderWidth)
        return viewWithTag(tag)!
    }
    private func setBorder(color:UIColor,
                           thickness:CGFloat = 1) {
        clipsToBounds = true
        
    }
}
