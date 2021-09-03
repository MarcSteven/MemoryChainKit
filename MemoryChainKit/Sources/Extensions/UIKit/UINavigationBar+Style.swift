//
//  UINavigationBar+Style.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/14.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import UIKit


public extension UINavigationBar {
    
    func setTitleAlpha(_ alpha: CGFloat) {
        let color = titleTextAttributes?[.foregroundColor] as? UIColor ?? defaultTitleColor
        setTitleColor(color.withAlphaComponent(alpha))
    }
    
    @available(iOS 11.0, *)
    func setLargeTitleAlpha(_ alpha: CGFloat) {
        let color = largeTitleTextAttributes?[.foregroundColor] as? UIColor ?? defaultTitleColor
        setLargeTitleColor(color.withAlphaComponent(alpha))
    }
    
    func setTintAlpha(_ alpha: CGFloat) {
        tintColor = tintColor.withAlphaComponent(alpha)
    }
}

private extension UINavigationBar {
    
    var defaultTitleColor: UIColor {
        return barStyle == .default ? UIColor.black : UIColor.white
    }
    
    func setTitleColor(_ color: UIColor) {
        if var titleTextAttributes = titleTextAttributes {
            titleTextAttributes[.foregroundColor] = color
            self.titleTextAttributes = titleTextAttributes
        } else {
            titleTextAttributes = [.foregroundColor: color]
        }
    }
    
    @available(iOS 11.0, *)
    func setLargeTitleColor(_ color: UIColor) {
        if var largeTitleTextAttributes = largeTitleTextAttributes {
            largeTitleTextAttributes[.foregroundColor] = color
            self.largeTitleTextAttributes = largeTitleTextAttributes
        } else {
            self.largeTitleTextAttributes = [.foregroundColor: color]
        }
    }
}
public extension UINavigationBar {
    func apply(_ style:Stylable) {
        applyColors(barColor:style.barColor , barTintColor: style.tintColor)
    }
    func applyColors(barColor:UIColor?,
                     barTintColor:UIColor) {
        self.isTranslucent = false
        self.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor:barTintColor
        ]
        self.tintColor = barTintColor
        self.barTintColor = barTintColor
        guard #available(iOS 11.0, *) else {return }
            self.largeTitleTextAttributes = [
                NSAttributedString.Key.foregroundColor:barTintColor
            ]
        
    }
    func setTitleFont(_ font:UIFont) {
        titleTextAttributes = [.font:font]
    }
   
    func makeTransparent() {
        isTranslucent = true
        backgroundColor = .clear
        barTintColor = .clear
        setBackgroundImage(UIImage(), for: .default)
        shadowImage = UIImage()
    }
    
}
public extension UINavigationBar {
    func hideBottomHairline() {
        let navigationBarImageView = hairlineImageViewInNavigationBar(view: self)
        navigationBarImageView?.isHidden = true
    }
    func showBottomHairLine() {
        
        let navigationBarImageView = hairlineImageViewInNavigationBar(view: self)
        navigationBarImageView?.isHidden = false 
    }
    func changeBottomHairImage() {}
    private func hairlineImageViewInNavigationBar(view: UIView) -> UIImageView? {
        if let view = view as? UIImageView, view.bounds.height <= 1.0 {
            return view
        }
        
        for subview in view.subviews {
            if let imageView = hairlineImageViewInNavigationBar(view: subview) {
                return imageView
            }
        }
        
        return nil
    }
}
