//
//  TimeInterval+HasPassed.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/13.
//  Copyright © 2020 Marc Steven(.com/MarcSteven). All rights reserved.
//

import Foundation

extension TimeInterval {
    public func hasPassed(since:Self) ->Bool {
        return Date().timeIntervalSinceReferenceDate - self > since
    }
}
