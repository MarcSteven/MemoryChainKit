//
//  OptionalExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/14.
//  Copyright © 2020 Marc Zhao(https://github.com/MarcSteven). All rights reserved.
//

import Foundation

public extension Optional where Wrapped ==String {
    var isBlank:Bool {
        return self?.isBlank ?? true 
    }
    var isNill:Bool {
        return self == nil
    }
    
}

public extension Optional where Wrapped == String {
    var unwrappedOrEmpty: String {
        switch self {
        case let .some(wrapped):
            return wrapped
        default:
            return ""
        }
    }
}
public extension Optional where Wrapped: Collection {
    var isNilOrEmpty: Bool {
        switch self {
        case let .some(wrapped):
            return wrapped.isEmpty
        default:
            return true
        }
    }
}
