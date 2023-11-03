//
//  CellOptions.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/24.
//  Copyright © 2020 Marc Steven(.com/MarcSteven). All rights reserved.
//

import Foundation

public struct CellOptions: OptionSet {
    public let rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    public static let move = Self(rawValue: 1 << 0)
    public static let delete = Self(rawValue: 1 << 1)
    public static let none: Self = []
    public static let all: Self = [move, delete]
}
