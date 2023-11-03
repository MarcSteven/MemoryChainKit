//
//  Configurable.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/3.
//  Copyright © 2020 Marc Steven(.com/MarcSteven). All rights reserved.
//

public protocol Configurable {
    associatedtype ObjectType
    func configure(_ object:ObjectType)
}

public struct AnyConfigurable<T> {
    public let base:Any
    private let _configure:(_ object:T) ->Void
    public init<C:Configurable>(_ base:C) where C.ObjectType == T {
        self.base = base
        self._configure = {
            base.configure($0)
        }
    }
}

extension AnyConfigurable:Configurable {
    public func configure(_ object: T) {
        _configure(object)
    }
}
