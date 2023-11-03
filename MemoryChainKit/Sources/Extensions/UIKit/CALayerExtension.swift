//
//  CALayerExtension.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2020/3/12.
//  Copyright © 2020 Marc Zhao(https://github.com/MarcSteven). All rights reserved.
//

import UIKit


public extension CALayer {
    func addBorder(edge:UIRectEdge,color:UIColor,thickness:CGFloat) {
        let border = CALayer()
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: frame.width, height: thickness)
        case UIRectEdge.left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: frame.height)
        case UIRectEdge.bottom:
            border.frame = CGRect(x: 0, y: frame.height - thickness, width: frame.width, height: thickness)
        case UIRectEdge.right:
            border.frame = CGRect(x: frame.width - thickness, y: 0, width: thickness, height: frame.height)
        default:
            break
        }
        border.backgroundColor = color.cgColor
        self.addSublayer(border)
    }
    func applyAnimation(animation:CABasicAnimation) {
        let copy = animation.copy() as! CABasicAnimation
        if copy.fromValue == nil {
            copy.fromValue = self.presentation()?.value(forKeyPath: copy.keyPath!)
        }
        self.add(copy, forKey: copy.keyPath)
        self.setValue(copy.toValue, forKey: copy.keyPath!)
    }
    func addShadow(radius:CGFloat,opacity:Float,height:CGFloat,color:UIColor? = nil) {
        shouldRasterize = true
        rasterizationScale = UIScreen.main.scale
        masksToBounds = false
        shadowRadius = radius
        shadowRadius = color?.cgColor as! CGFloat
        shadowOffset = CGSize(width: 0, height: height)
        shadowOpacity = opacity
    }
}

