//
//  UserDefaultsStore.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/18.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation

final public class UserDefaultsStore<T:Codable> {
    private let storage:UserDefaults
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
        self.storage = storage
        
    }
    public var value:T? {
        get {
            if  let cachedValueInMemory = cachedValueInMemory {
                return cachedValueInMemory
            }
            guard let data = storage.object(forKey: key) as? Data, let value = try? decoder.decode(T.self, from: data)  else {
                return defaultValue
            }
            if shouldCacheValueInMemory {
                cachedValueInMemory = value
            }
            return value
        }
        set {
            let data = newValue == nil ? nil : try? encoder.encode(newValue)
            storage.set(data, forKey: key)
            if shouldCacheValueInMemory {
                cachedValueInMemory = newValue
            }
        }
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

extension UserDefaultsStore :CustomStringConvertible {
    public var description: String {
        guard let value = value as? CustomStringConvertible else {
            return String(describing: self.value)
        }
        return value.description
    }
}
extension UserDefaultsStore:CustomDebugStringConvertible {
    public var debugDescription: String {
        return value.debugDescription
    }
}
