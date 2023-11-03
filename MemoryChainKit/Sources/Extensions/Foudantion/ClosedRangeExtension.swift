//
//  ClosedRangeExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/23.
//  Copyright © 2020 Marc Steven(.com/MarcSteven). All rights reserved.
//

import Foundation

extension ClosedRange where Bound:FloatingPoint {
    public func random() ->Bound {
        let range = upperBound - lowerBound
        return (Bound(UInt32.random(in: 0..<UInt32.max)) / Bound(UInt32.max)) * range + lowerBound
    }
}
