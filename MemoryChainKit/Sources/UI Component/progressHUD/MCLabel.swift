//
//  MCLabel.swift
//  MemoryChainUIKit
//
//  Created by Marc Zhao on 2018/9/16.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation
import QuartzCore
import UIKit

open class MCLabel:UIView {
    
    let gradientLabelLayer:CAGradientLayer = {
       let gradientLayer = CAGradientLayer()
        
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        let colors :[CGColor] = [
        UIColor.black.cgColor,
        UIColor.white.cgColor,
        UIColor.black.cgColor
        ]
        gradientLayer.colors = colors
        let locations:[NSNumber] = [
            0.0,0.5,1.0
        ]
        gradientLayer.locations = locations
        
        return gradientLayer
        
    }()
    let textAttributesForLabel:[NSAttributedStringKey:Any] = {
       let ps = NSMutableParagraphStyle()
        ps.alignment = .center
        
        return [
            (kCTParagraphStyleAttributeName as NSString) as NSAttributedStringKey: ps
        ]
    }()
    @IBInspectable var text:String! {
        didSet {
            setNeedsDisplay()
            let image = UIGraphicsImageRenderer(size: bounds.size)
                .image { _  in
                    text.draw(in: bounds, withAttributes: textAttributesForLabel as [NSAttributedStringKey : Any])
                    
            }
            let maskLayer = CALayer()
            maskLayer.backgroundColor =  UIColor.clear.cgColor
            maskLayer.frame = bounds.offsetBy(dx: bounds.size.width, dy: 0)
            maskLayer.contents = image.cgImage
            
            gradientLabelLayer.mask = maskLayer
        }
    }
    
    override open func layoutSubviews() {
        gradientLabelLayer.frame = CGRect(x: -bounds.size.width, y: bounds.origin.y, width: 3 * bounds.size.width, height: bounds.size.height)
        
    }
    override open func didMoveToWindow() {
        super.didMoveToWindow()
        layer.addSublayer(gradientLabelLayer)
        
        let labelAniamtion = CABasicAnimation(keyPath: "positions")
        labelAniamtion.fromValue = [0.0,0.0,0.25]
        labelAniamtion.toValue = [0.75,1.0,1.0]
        labelAniamtion.duration = 1.5
        labelAniamtion.repeatCount = Float.infinity
        
        gradientLabelLayer.add(labelAniamtion, forKey: nil)
    }
}

