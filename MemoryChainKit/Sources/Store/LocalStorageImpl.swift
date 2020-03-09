//
//  LocalStorageImpl.swift
//  MemoryChain
//
//  Created by Marc Zhao on 2018/9/6.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation

struct LocalStorageKeys {
    private init() {}
    
    static let isLoggedIn = "logged_in"
}

class LocalStorageImpl: LocalStorage {
    
    let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
        userDefaults.register(defaults: [LocalStorageKeys.isLoggedIn: false])
    }
    
    var isLoggedIn: Bool {
        get {
            return userDefaults.bool(forKey: LocalStorageKeys.isLoggedIn)
        } set {
            userDefaults.set(newValue, forKey: LocalStorageKeys.isLoggedIn)
        }
    }
    
    func clear() {
        userDefaults.removeObject(forKey: LocalStorageKeys.isLoggedIn)
    }
    
}

