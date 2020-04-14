//
//  Stylable.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/3/2.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit

public protocol Stylable {
    var barColor:UIColor? {get}
    var tintColor:UIColor {get}
    var statusBarStyle:UIStatusBarStyle {get}
}
public struct BasicNavigationBarStyle:Stylable {
    
    public var barColor:UIColor? = nil
    public var tintColor:UIColor = .black
    public var statusBarStyle:UIStatusBarStyle = .default
}
