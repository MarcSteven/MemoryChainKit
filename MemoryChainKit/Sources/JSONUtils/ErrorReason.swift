//
//  ErrorReason.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2018/12/28.
//  Copyright © 2018 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation


/**
 
 the reason error occurred
 
 */
public enum ErrorReason:String,CustomStringConvertible {
    ///key was not found in a json Dictionary
    case keyNotFound = "Key not found"
    /// A value was found that cannot initialise a rawReprentable.In the case of an enum,the rawValue didn't match any of the case's rawValue
    case incorrectRawPresentableRawValue = "Incorrrect RawPresentable RawValue"
    ///The value has the incorrect type
    case incorrectType = "Incorrect type"
    ///A jsonPrimitiveConvertible failed to convert
    case conversionFailure = "Conversion failure"
    public var description: String {
        return rawValue
    }
}
