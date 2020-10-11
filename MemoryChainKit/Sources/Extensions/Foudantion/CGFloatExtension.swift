//
//  CGFloatExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/10/11.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation
import UIKit

/// The value of `π` as a `CGFloat`.
public let π = CGFloat.pi

public extension CGFloat {
    /// A convenience method to convert an angle from degrees to radians.
    ///
    /// - Returns: `self` value in radians.
     func degreesToRadians() -> CGFloat {
        π * self / 180
    }

    /// A convenience method to convert an angle from radians to degrees.
    ///
    /// - Returns: `self` value in degrees.
     func radiansToDegrees() -> CGFloat {
        self * 180 / π
    }
}
