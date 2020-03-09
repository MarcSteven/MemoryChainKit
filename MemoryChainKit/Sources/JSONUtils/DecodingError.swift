//
//  DecodingError.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2018/12/28.
//  Copyright © 2018 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation

/**
 
 Error that occurs when decoding
 */
public struct DecodingError:Error,CustomStringConvertible,CustomDebugStringConvertible {
    
    ///The reason the error occurred
    public var reason:ErrorReason
    
    /// dictionary in which the error occured
    public let dictionary: [AnyHashable: Any]
    
    /// array in which the error occurred
    public let array: JSONArray?
    
    /// the keypath at which the error occurred
    public let keyPath: String
    
    /// the expected type that was being decoded while the error happened
    public let expectedType: Any
    
    /// the value that caused the error
    public let value: Any
    
    init(dictionary: [AnyHashable: Any], keyPath: StringProtocol, expectedType: Any.Type, value: Any, array: JSONArray? = nil, reason: ErrorReason) {
        self.dictionary = dictionary
        self.keyPath = keyPath.string
        self.expectedType = expectedType
        self.value = value
        self.reason = reason
        self.array = array
    }
    
    var reasonDescription: String {
        switch reason {
        case .keyNotFound:
            return "Nothing found"
        case .incorrectRawPresentableRawValue:
            return "Incorrect rawValue of \(value) for \(expectedType)"
        case .incorrectType:
            return "Incorrect type, expected \(expectedType) found \(value)"
        case .conversionFailure:
            return "\(expectedType) failed to convert \(value)"
        }
    }
    
    public var description: String {
        return "Decoding failed at \"\(keyPath)\": \(reasonDescription)"
    }

    public var debugDescription: String {
        return "\(description):\n\(array?.description ?? dictionary.description)"
    }
    
}
