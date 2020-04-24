//
//  JSONDeserializableError.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/24.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation

/// Errors for deserializing JSON representations
public enum JSONDeserializationError: Error {
    /// A required attribute was missing
    case missingAttribute(key: String)

    /// An invalid type for an attribute was found
    case invalidAttributeType(key: String, expectedType: Any.Type, receivedValue: Any)

    /// An attribute was invalid
    case invalidAttribute(key: String)
}
