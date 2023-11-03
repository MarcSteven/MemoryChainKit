//
//  CGColorExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/19.
//  Copyright © 2020 Marc Steven(.com/MarcSteven). All rights reserved.
//

import UIKit
import QuartzCore

extension CGColor {
    public var uiColor:UIColor {
        return UIColor(cgColor: self)
    }
}
