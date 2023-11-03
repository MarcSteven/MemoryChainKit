//
//  CAMediaTimingFunction+Properties.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/19.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import QuartzCore
import UIKit

extension CAMediaTimingFunction {
        public static let `default` = CAMediaTimingFunction(name: .default)
        public static let linear = CAMediaTimingFunction(name: .linear)
        public static let easeIn = CAMediaTimingFunction(name: .easeIn)
        public static let easeOut = CAMediaTimingFunction(name: .easeOut)
        public static let easeInEaseOut = CAMediaTimingFunction(name: .easeInEaseOut)
}
