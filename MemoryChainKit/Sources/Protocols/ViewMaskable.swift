//
//  ViewMaskable.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/6.
//  Copyright © 2020 Marc Steven(.com/MarcSteven). All rights reserved.
//

import UIKit 


public protocol ViewMaskable: AnyObject {
    static func add(to superview: UIView) -> Self
    func dismiss(_ completion: (() -> Void)?)
    var preferredNavigationBarTintColor: UIColor { get }
    var preferredStatusBarStyle: UIStatusBarStyle { get }
}

extension ViewMaskable {
    public var preferredNavigationBarTintColor: UIColor {
        .appTint
    }

    public var preferredStatusBarStyle: UIStatusBarStyle {
        preferredNavigationBarTintColor == .white ? .lightContent : .default
    }

    public func dismiss(after delayDuration: TimeInterval, _ completion: (() -> Void)? = nil) {
        
      
    }
}
