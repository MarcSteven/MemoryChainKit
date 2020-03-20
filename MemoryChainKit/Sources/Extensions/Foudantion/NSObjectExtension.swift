//
//  NSObjectExtension.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2020/3/10.
//  Copyright © 2020 Marc Zhao(https://github.com/MarcSteven). All rights reserved.
//

import Foundation


extension NSObject {
    var memoryAddress: String {
        String(describing: Unmanaged<NSObject>.passUnretained(self).toOpaque())
    }
}

extension NSObject {
    /// Returns the value for the property identified by a given key.
    ///
    /// The search pattern that `valueForKey:` uses to find the correct value
    /// to return is described in **Accessor Search Patterns** in **Key-Value Coding Programming Guide**.
    ///
    /// - Parameter key: The name of one of the receiver's properties.
    /// - Returns: The value for the property identified by key.
    open func safeValue(forKey key: String) -> Any? {
        let mirror = Mirror(reflecting: self)

        for child in mirror.children.makeIterator() where child.label == key {
            return child.value
        }

        return nil
    }

    /// Return `true` if the `self` has the property of given `name`; otherwise, `false`.
    open func hasProperty(withName name: String) -> Bool {
        safeValue(forKey: name) != nil
    }
}

// MARK: LookupComparison

extension NSObject {
    public enum LookupComparison {
        /// Indicates whether the receiver is an instance of given class or an
        /// instance of any class that inherits from that class.
        case kindOf

        /// The dynamic type.
        case typeOf
    }

    /// - Parameters:
    ///   - aClass: A class object representing the Objective-C class to be tested.
    ///   - comparison: The comparison option to use when comparing `self` to `aClass`.
    ///
    /// - Returns: When option is `.kindOf` then this method returns true if `aClass` is a Class object of the same type.
    ///            Otherwise, `.typeOf` does direct check to ensure `aClass` is the same object and not a subclass.
    public func isType(of aClass: Swift.AnyClass, comparison: LookupComparison) -> Bool {
        switch comparison {
            case .kindOf:
                return isKind(of: aClass)
            case .typeOf:
                return aClass.self == type(of: self)
        }
    }
}

// MARK: Property List


