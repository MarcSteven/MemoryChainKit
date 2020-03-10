//
//  Array+RemoveIndex.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/1/5.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation
//Remove multiple indexes from Array
extension Array {
    public mutating func remove(at indexs:Set<Int>) {
        for i in Array<Int>(indexs).sorted(by: >) {
            self.remove(at: i)
        }
    }
    
    //Array方法扩展，支持根据索引数组删除
    
    public mutating func removeAtIndexes(indexs: [Int]) {
        let sorted = indexs.sorted(by: { $1 < $0 })
        for index in sorted {
            self.remove(at: index)
        }
    }
}
public extension Array {
    subscript(guarded index:Int) ->Element? {
        guard (startIndex..<endIndex).contains(index) else {
            return nil
        }
        return self[index]
    }
}

