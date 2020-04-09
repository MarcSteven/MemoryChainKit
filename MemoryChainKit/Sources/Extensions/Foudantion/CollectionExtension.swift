//
//  CollectionExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/9.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation

extension Sequence where Iterator.Element:Hashable {
    
    // return an array containing only the unique element of self in order
    public func unique() ->[Iterator.Element] {
        var seen:[Iterator.Element:Bool] = [:]
        return filter{seen.updateValue(true, forKey: $0) == nil }
    }
}
extension Sequence {
    //return an array containing only the unique elements of self
    public func unique<T:Hashable>(_ uniqueProperty:(Iterator.Element)->T)->[Iterator.Element] {
        var seen:[T:Bool] = [:]
        return filter({seen.updateValue(true, forKey: $0 as! T) == nil})
    }
}

extension Array where Element:Hashable {
    public mutating func uniqueInPlace() {
        self = unique()
        
    }
    public mutating func uniqueInPlace<T:Hashable>(_ uniqueProperty:(Element)->T) {
        self = unique(uniqueProperty)
    }
}


extension Collection {
    public func count(where predicate:(Element) throws ->Bool) rethrows ->Int {
        try filter(predicate).count
    }
}

extension RangeReplaceableCollection {
    public mutating func removingAll(where predicate:(Element)throws ->Bool)rethrows ->Self {
        let result = try filter(predicate)
        try removeAll(where: predicate)
        return result
    }
}
extension RangeReplaceableCollection where Element:Equatable,Index == Int {
    // remove element by value
    @discardableResult
    public mutating func remove(_ element:Element)->Bool {
        for(index,elementToCompare) in enumerated() where element == elementToCompare {
            remove(at: index)
            return true
        }
        return false
    }
    public mutating func remove(_ elements:[Element]) {
        elements.forEach({remove($0)})
    }
    // remove an element to a specific index
    @discardableResult
    public mutating func move(_ element: Element, to index: Int) -> Bool {
        guard remove(element) else {
            return false
        }

        insert(element, at: index)
        return true
    }

}

extension Collection {
    /// Returns the element at the specified index iff it is within bounds, otherwise `nil`.
    public func at(_ index: Index) -> Iterator.Element? {
        indices.contains(index) ? self[index] : nil
    }
}

extension Collection {
    /// Returns the `SubSequence` at the specified range iff it is within bounds, otherwise `nil`.
    public func at(_ range: Range<Index>) -> SubSequence? {
        hasIndex(range) ? self[range] : nil
    }

    /// Return true iff range is in `self`.
    public func hasIndex(_ range: Range<Index>) -> Bool {
        range.lowerBound >= startIndex && range.upperBound <= endIndex
    }
}

extension RandomAccessCollection where Index == Int {
    /// Returns the `SubSequence` at the specified range iff it is within bounds, otherwise `nil`.
    public func at(_ range: CountableRange<Index>) -> SubSequence? {
        hasIndex(range) ? self[range] : nil
    }

    /// Return true iff range is in `self`.
    public func hasIndex(_ range: CountableRange<Index>) -> Bool {
        range.lowerBound >= startIndex && range.upperBound <= endIndex
    }

    /// Returns the `SubSequence` at the specified range iff it is within bounds, otherwise `nil`.
    public func at(_ range: CountableClosedRange<Index>) -> SubSequence? {
        hasIndex(range) ? self[range] : nil
    }

    /// Return true iff range is in `self`.
    public func hasIndex(_ range: CountableClosedRange<Index>) -> Bool {
        range.lowerBound >= startIndex && range.upperBound <= endIndex
    }
}
