//
//  CALayer+Border.swift
//  MemoryChain
//
//  Created by Marc Zhao on 2018/8/10.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
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
}
