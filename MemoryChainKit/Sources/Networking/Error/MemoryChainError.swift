//
//  MemoryChainError.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/14.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation


/**
 MemoryChain error protocol, all the errors related to memoryChain should conform to this protocol
 */

public protocol MemoryChainError:Error,CustomStringConvertible {
    /**
     method that will allow us to compare two errors
     */
    func isEqual(error:MemoryChainError) ->Bool
}

public extension MemoryChainError where Self:Equatable {
    public func isEqual(error:MemoryChainError) ->Bool {
        if let error = error as? Self {return self == error}
        return false
    }
}
