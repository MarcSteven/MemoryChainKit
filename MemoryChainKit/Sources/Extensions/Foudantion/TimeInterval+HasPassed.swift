//
//  TimeInterval+HasPassed.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/13.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation

public extension TimeInterval {
    func hasPassed(since:Self) ->Bool {
        return Date().timeIntervalSinceReferenceDate - self > since
    }
}
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
