//
//  DataContaining.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2018/12/11.
//  Copyright © 2018 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation

public protocol DataContaining {
    associatedtype ItemType
    var data:[ItemType] { get }
}

public extension DataContaining {
    var numberOfItems:Int {
        return data.count
    }
    func item(at index:Int) ->ItemType? {
        guard index < numberOfItems else {
            return nil
        }
        return data[index]
    }
}
extension Array:DataContaining {
    public typealias ItemType = Element
    public var data :[ItemType] {
        return self
    }
    
}

public protocol MutableDataContaining:DataContaining {
    var data:[ItemType] { get set }
}
public extension MutableDataContaining {
    mutating func insert( _ item:ItemType,at index:Int) {
        data.insert(item, at: index)
    }
}
