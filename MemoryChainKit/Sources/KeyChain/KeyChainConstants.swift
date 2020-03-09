//
//  KeyChainConstants.swift
//  MemoryChain
//
//  Created by Marc Zhao on 2018/8/7.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation
import Security


/*
 
 key chain constant
 
 */
public struct KeychainConstant {
    public static var accessGroup :String {return toString(kSecAttrAccessGroup)}
    public static var  accessible:String {
        return toString(kSecAttrAccessible)
        
    }
    public static var attrAccount: String { return toString(kSecAttrAccount) }
    
    /// Used for specifying synchronization of keychain items between devices.
    public static var attrSynchronizable: String { return toString(kSecAttrSynchronizable) }
    
    /// An item class key used to construct a Keychain search dictionary.
    public static var klass: String { return toString(kSecClass) }
    
    /// Specifies the number of values returned from the keychain. The library only supports single values.
    public static var matchLimit: String { return toString(kSecMatchLimit) }
    
    /// A return data type used to get the data from the Keychain.
    public static var returnData: String { return toString(kSecReturnData) }
    
    /// Used for specifying a value when setting a Keychain value.
    public static var valueData: String { return toString(kSecValueData) }
    static func toString(_ value:CFString) ->String {
        return value  as String
    }
}



