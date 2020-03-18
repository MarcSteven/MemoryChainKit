//
//  NSArray+Extension.swift
//  MemoryChain
//
//  Created by Marc Zhao on 2018/8/6.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation


public extension NSArray {
    func uniq<S:Sequence,T:Hashable>(source :S) ->[T] where S.Iterator.Element == T {
        var buffer = [T]()
        var added = Set<T>()
        for element in source {
            if !added.contains(element) {
                buffer.append(element)
                added.insert(element)
            }
        }
        return buffer
    }

}


