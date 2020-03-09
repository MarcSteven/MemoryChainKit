//
//  NSLayoutDimension+Extension.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/1/3.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit


@available(iOS 9.0, *)
public extension NSLayoutDimension {
    
    @objc
    func constrain(equalToConstant constant: CGFloat) {
        constraint(equalToConstant: constant).activate()
    }
    
    @objc
    func constrain(lessThanOrEqualToConstant constant: CGFloat) {
        constraint(lessThanOrEqualToConstant: constant).activate()
    }
    
    @objc
    func constrain(greaterThanOrEqualToConstant constant: CGFloat) {
        constraint(greaterThanOrEqualToConstant: constant).activate()
    }
    
    @objc
    func constrain(equalTo dimension: NSLayoutDimension, multiplier: CGFloat = 1, constant: CGFloat = 0) {
        constraint(equalTo: dimension, multiplier: multiplier, constant: constant).activate()
    }
    
    @objc
    func constrain(lessThanOrEqualTo dimension: NSLayoutDimension, multiplier: CGFloat = 1, constant: CGFloat = 0) {
        constraint(lessThanOrEqualTo: dimension, multiplier: multiplier, constant: constant).activate()
    }
    
    @objc
    func constrain(greaterThanOrEqualTo dimension: NSLayoutDimension, multiplier: CGFloat = 1, constant: CGFloat = 0) {
        constraint(greaterThanOrEqualTo: dimension, multiplier: multiplier, constant: constant).activate()
    }
}

//MARK: - NSLayoutContstaint helper method 
extension NSLayoutConstraint {
    
}
