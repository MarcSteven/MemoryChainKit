//
//  KeyChainAccessOptions.swift
//  MemoryChain
//
//  Created by Marc Zhao on 2018/8/7.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation


public enum KeychainAccessOptions {
    case accessibleWhenUnlocked
    case accessibleWhenUnlockedThisDeviceOnly
    case accessibleAfterFirstUnlock
    case accessibleAfterFirstUnlockThisDeviceOnly
    case accessibleAlways
    case accessibleWhenPasscodeSetThisDeviceOnly
    case accessibleAlwaysThisDeviceOnly
    static var defaultOptions:KeychainAccessOptions {
        return .accessibleWhenUnlocked
    }
    var value:String {
        switch self {
        case .accessibleAfterFirstUnlock:
            return toString(kSecAttrAccessibleWhenUnlocked)
            
        case .accessibleAlwaysThisDeviceOnly:
            return toString(kSecAttrAccessibleAlwaysThisDeviceOnly)
        case .accessibleWhenUnlockedThisDeviceOnly:
            return toString(kSecAttrAccessibleWhenUnlockedThisDeviceOnly)
        case .accessibleAlways:
            return toString(kSecAttrAccessibleAlways)
        case .accessibleWhenPasscodeSetThisDeviceOnly:
            return toString(kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly)
            
        case .accessibleAfterFirstUnlockThisDeviceOnly:
            return toString(kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly)
        case .accessibleWhenUnlocked:
            return toString(kSecAttrAccessibleWhenUnlocked)
        }
    }
    //Convert to string 
    func toString(_ value:CFString) ->String {
        return KeychainConstant.toString(_:value)
    }
}
