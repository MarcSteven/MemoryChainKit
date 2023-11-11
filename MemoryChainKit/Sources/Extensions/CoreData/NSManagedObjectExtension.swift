//
//  NSManagedObjectExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2023/11/4.
//  Copyright © 2023 Marc Steven(https://marcsteven.top). All rights reserved.
//

import CoreData


public extension NSManagedObject {
    func setRawValue<ValueType:RawRepresentable>(_ value:ValueType?,forKey key:String) {
        willChangeValue(forKey: key)
        setPrimitiveValue(value?.rawValue, forKey: key)
        didChangeValue(forKey: key)
    }
    func rawValue<ValueType:RawRepresentable>(forKey key:String) ->ValueType? {
        willAccessValue(forKey: key)
        let result = primitiveValue(forKey: key) as? ValueType.RawValue
        didAccessValue(forKey: key)
        return result.flatMap({ValueType(rawValue: $0)})
    }
    
        /// Lookup an object by its NSManagedObjectID
        ///
        /// - Parameters:
        ///   - objectID: The `NSManagedObject` subclass' objectID as defined by Core Data.
        ///   - context:  An NSManagedObjectContext that contains the associated object.
        /// - Returns: The `NSManagedObject` subclass associated with the given `objectID`, if it exists.
        static func lookup(withObjectID objectID: NSManagedObjectID, in context: NSManagedObjectContext) -> Self? {
            return try? context.existingObject(with: objectID) as? Self
        }
    
}
