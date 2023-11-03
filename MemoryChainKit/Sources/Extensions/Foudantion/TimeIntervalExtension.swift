//
//  TimeIntervalExtension.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2020/3/10.
//  Copyright © 2020 Marc Zhao(.com/MarcSteven). All rights reserved.
//

import Foundation

public extension TimeInterval {
    static func days(_ quanlity:Double) ->TimeInterval {
        return hours(24) * quanlity
    }
    static func hours(_ quanlity:Double) ->TimeInterval {
        return minutes(60) * quanlity
    }
    static func minutes(_ quantity:Double) ->TimeInterval {
        return 60 * quantity
    }
}
