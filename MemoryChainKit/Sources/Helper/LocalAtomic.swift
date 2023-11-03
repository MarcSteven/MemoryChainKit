//
//  LocalAtomic.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/8.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation


open class LocalAtomic<T> {
    private var value:T {
        get {
            return sync.safeSync { return __value}
        }
        set {
            sync.safeSync {__value = newValue}
        }
    }
    private var __value:T
    private let sync:DispatchQueue
    //MARK: - initialization
    private init(value:T,
                 queue:DispatchQueue? = nil) {
        self.__value = value
        self.sync = queue ?? DispatchQueue(label: "")
    }
    public static func generateAccessors(value:T,
                                         queue:DispatchQueue? = nil) ->(get:() ->T,set:(T)->Void) {
        let atomic = LocalAtomic<T>(value: value, queue: queue)
        return ({return atomic.value}, {atomic.value = $0})
    }
}
