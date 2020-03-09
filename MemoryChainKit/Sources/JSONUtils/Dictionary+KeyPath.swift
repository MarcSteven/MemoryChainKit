//
//  Dictionary+KeyPath.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2018/12/28.
//  Copyright © 2018 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation


public extension Dictionary {
    
    
    subscript(keyPath keyPath:StringProtocol) ->Any? {
        var keys = keyPath.components(separatedBy: ".")
        guard let firstKey = keys.first as? Key,
            let value = self[firstKey] else {
                return nil
        }
        keys.removeFirst()
        if !keys.isEmpty,let subDictionary = value as? [Key:Any] {
            let rejoined = keys.joined(separator: ".")
            return subDictionary[keyPath:rejoined]
        }
        return value
    }
}
