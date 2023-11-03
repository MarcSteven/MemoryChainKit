//
//  UserDefaultsExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/11/7.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import UIKit


public extension UserDefaults {
    func containsKey(_ key:String?) ->Bool {
        let value = object(forKey: key ?? "")
        return value != nil
    }
    func bool(for key:Any?,
              withDefault defaultValue:Bool) ->Bool {
        let value = object(forKey: key as? String ?? "")
        if value == nil {
            return defaultValue
        }
        return (value as? NSNumber)?.boolValue ?? false
    }
    func mc_setBool(_ b:Bool,
                    forKey key:String?) {
        setValue(NSNumber(value: b), forKey: key ?? "")
    }
    func ms_double(forKey key:String?,
                   withDefault defaultValue:Double) ->Double {
        
        let value = object(forKey: key ?? "")
        if value == nil {
            return defaultValue
        }
        return (value as? NSNumber)?.doubleValue ?? 0.0
    }
    func ms_setDouble(_ d: Double, forKey key: String?) {
            set(NSNumber(value: d), forKey: key ?? "")
        }

    func ms_integer(forKey key: String?, withDefault defaultValue: Int) -> Int {
            let value = object(forKey: key ?? "")
            if value == nil {
                return defaultValue
            }
            return (value as? NSNumber)?.intValue ?? 0
        }
    func ms_setInteger(_ integer: Int, forKey key: String?) {
            set(NSNumber(value: integer), forKey: key ?? "")
        }


}

