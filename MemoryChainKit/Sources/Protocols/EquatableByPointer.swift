//
//  EquatableByPointer.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/21.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation

public protocol EquatableByPointer:AnyObject, Equatable {}

extension EquatableByPointer {
    public static func ==(lhs:Self,rhs:Self) ->Bool {
        let lhs  = Unmanaged<Self>.passUnretained(lhs).toOpaque()
        let rhs = Unmanaged<Self>.passUnretained(rhs).toOpaque()
        return lhs == rhs
    }
}
