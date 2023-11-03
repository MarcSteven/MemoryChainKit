//
//  PropertyStoring.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/22.
//  Copyright © 2020 Marc Steven(.com/MarcSteven). All rights reserved.
//

import Foundation

public protocol PropertyStoring {
    associatedtype T
    func getAssociatedObject(_ key:UnsafeRawPointer!,
                             defaultValue:T) ->T
}

extension PropertyStoring {
    func getAssociatedObject(_ key:UnsafeRawPointer!,
                             defaultValue:T) ->T {
        guard  let value = objc_getAssociatedObject(self, key) as? T else {
            return defaultValue
        }
        return value
    }
}
