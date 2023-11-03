//
//  UserDefaults.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/13.
//  Copyright © 2020 Marc Steven(.com/MarcSteven). All rights reserved.
//

import Foundation


//Usage:

/// enum GlobalSettings {
//@UserDefaults(key:"is_first_launch",defaultValue:false)
//static var isFirstLaunch:Bool
//}


@propertyWrapper

public struct UserDefault<Value> {
    public let key:String
    public let defaultValue:Value
    public var wrappedValue:Value {
        get {
            UserDefaults.standard.object(forKey:key) as? Value ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}
