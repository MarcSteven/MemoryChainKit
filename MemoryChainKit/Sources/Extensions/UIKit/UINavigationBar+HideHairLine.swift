//
//  UINavigationBar+HideHairLine.swift
//  MemoryChainExtensionService
//
//  Created by Marc Zhao on 2018/9/12.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit


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
