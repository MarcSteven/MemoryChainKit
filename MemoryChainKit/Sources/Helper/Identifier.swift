//
//  Identifier.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/3.
//  Copyright © 2020 Marc Steven(.com/MarcSteven). All rights reserved.
//

import Foundation


public struct Identifier<Type>: RawRepresentable {
    public let rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

extension Identifier: ExpressibleByStringLiteral {
    public init(stringLiteral value: StringLiteralType) {
        self.init(rawValue: value)
    }
}

extension Identifier: CustomStringConvertible {
    public var description: String {
        rawValue
    }
}

extension Identifier: CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any {
        rawValue
    }
}

extension Identifier: Hashable {}

extension Identifier: Codable { }
