//
//  Range+Extension.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/5/14.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation

public extension  Range where Bound == String.Index {
    var nsRange:NSRange {
        return NSRange(location: self.lowerBound.encodedOffset, length: self.upperBound.encodedOffset - self.lowerBound.encodedOffset)
    }
}
