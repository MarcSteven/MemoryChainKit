//
//  CellOptions.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/24.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation

public struct CellOptions: OptionSet {
    public let rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    public static let move = CellOptions(rawValue: 1 << 0)
    public static let delete = CellOptions(rawValue: 1 << 1)
    public static let none: CellOptions = []
    public static let all: CellOptions = [move, delete]
}
