//
//  UserDefaultsStore.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/18.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation

final public class UserDefaultsStore<T:Codable> {
    private let shared:UserDefaults
    private lazy var encoder = JSONEncoder()
    private lazy var decoder = JSONDecoder()
    private var notificationToken:NSObjectProtocol?
    private let key:String
    private let defaultValue:T?
    private var cachedValueInMemory:T?
    private let shouldCacheValueInMemory:Bool
    public init(key:String,
                default defaultValue:T? = nil,
                shouldCacheValueInMemory:Bool = true,
                storage:UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.shouldCacheValueInMemory = shouldCacheValueInMemory
        self.shared = storage
        
    }
    private func setupApplicationMemoryWarningObserver() {
        notificationToken = NotificationCenter.on.applicationDidReceiveMemoryWarning {
            [weak self] in
            self?.cachedValueInMemory = nil
            
        }
    }
    deinit {
        NotificationCenter.remove(notificationToken)
    }
}
