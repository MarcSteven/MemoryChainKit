//
//  Collection+noEmpty.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/4/5.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation

public extension Collection {
    var nonEmpty:Self? {
        return isEmpty ? nil :self
    }
}
