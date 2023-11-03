//
//  Weak.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/20.
//  Copyright © 2020 Marc Steven(.com/MarcSteven). All rights reserved.
//



import Foundation

/// A generic class to hold a weak reference to a type `T`.
/// This is useful for holding a reference to nullable object.
///
/// ```swift
/// let views = [Weak<UIView>]()
/// ```
final public class Weak<Value: AnyObject> {
    public weak var value: Value?

    public init (_ value: Value) {
        self.value = value
    }
}

extension Weak: Equatable {
    public static func ==(lhs: Weak, rhs: Weak) -> Bool {
        lhs.value === rhs.value
    }

    public static func ==(lhs: Weak, rhs: Value) -> Bool {
        lhs.value === rhs
    }
}

extension Weak: Hashable where Value: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(value)
    }
}

extension RangeReplaceableCollection where Element: Weak<AnyObject>, Index == Int {
    /// Removes all elements where the `value` is deallocated.
    public mutating func flatten() {
        for (index, element) in enumerated() where element.value == nil {
            remove(at: index)
        }
    }
}
