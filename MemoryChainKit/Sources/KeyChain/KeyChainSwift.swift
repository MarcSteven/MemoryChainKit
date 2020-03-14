//
//  KeyChainSwift.swift
//  MemoryChain
//
//  Created by Marc Zhao on 2018/8/7.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation

//MARK: - keyChain swift
open   class KeychainSwift {
    var lastQueryParameters:[String:Any]?
    open var lastResultCode:OSStatus = noErr
    var keyPrefix = ""
    open var accessGroup:String?
    open var synchronizable:Bool = false
    private let readLock = NSLock()
    public init() {}
    public init(keyPrefix:String) {
        self.keyPrefix = keyPrefix
    }
    @discardableResult
    open func set(_ value:String,forKey key:String,
                  withAccess access:KeychainAccessOptions? = nil) ->Bool {
        if let value = value.data(using: String.Encoding.utf8) {
            return set(value,forKey:key,withAccess:access)
        }
        return false
    }
    @discardableResult
    open func set(_ value:Data,forKey key:String,
                  withAccess access:KeychainAccessOptions? = nil ) ->Bool {
        delete(key) // Delete any existing key before saving it
        let accessible = access?.value ?? KeychainAccessOptions.defaultOptions.value
        
        let prefixedKey = keyWithPrefix(key)
        
        var query: [String : Any] = [
            KeychainConstant.klass       : kSecClassGenericPassword,
            KeychainConstant.attrAccount : prefixedKey,
            KeychainConstant.valueData   : value,
            KeychainConstant.accessible  : accessible
        ]
        
        query = addAccessGroupWhenPresent(query)
        query = addSynchronizableIfRequired(query, addingItems: true)
        lastQueryParameters = query
        
        lastResultCode = SecItemAdd(query as CFDictionary, nil)
        
        return lastResultCode == noErr
    }
    
    /**
     Stores the boolean value in the keychain item under the given key.
     - parameter key: Key under which the value is stored in the keychain.
     - parameter value: Boolean to be written to the keychain.
     - parameter withAccess: Value that indicates when your app needs access to the value in the keychain item. By default the .AccessibleWhenUnlocked option is used that permits the data to be accessed only while the device is unlocked by the user.
     - returns: True if the value was successfully written to the keychain.
     */
    @discardableResult
    open func set(_ value: Bool, forKey key: String,
                  withAccess access: KeychainAccessOptions? = nil) -> Bool {
        
        let bytes: [UInt8] = value ? [1] : [0]
        //let data = Data(bytes: bytes)
        let data = Data(_: bytes)
        
        return set(data, forKey: key, withAccess: access)
    }
    
    /**
     
     Retrieves the text value from the keychain that corresponds to the given key.
     
     - parameter key: The key that is used to read the keychain item.
     - returns: The text value from the keychain. Returns nil if unable to read the item.
     
     */
    open func get(_ key: String) -> String? {
        if let data = getData(key) {
            
            if let currentString = String(data: data, encoding: .utf8) {
                return currentString
            }
            
            lastResultCode = -67853 // errSecInvalidEncoding
        }
        
        return nil
    }
    
    /**
     
     Retrieves the data from the keychain that corresponds to the given key.
     
     - parameter key: The key that is used to read the keychain item.
     - returns: The text value from the keychain. Returns nil if unable to read the item.
     
     */
    open func getData(_ key: String) -> Data? {
        // The lock prevents the code to be run simlultaneously
        // from multiple threads which may result in crashing
        readLock.lock()
        defer { readLock.unlock() }
        
        let prefixedKey = keyWithPrefix(key)
        
        var query: [String: Any] = [
            KeychainConstant.klass       : kSecClassGenericPassword,
            KeychainConstant.attrAccount : prefixedKey,
            KeychainConstant.returnData  : kCFBooleanTrue!,
            KeychainConstant.matchLimit  : kSecMatchLimitOne
        ]
        
        query = addAccessGroupWhenPresent(query)
        query = addSynchronizableIfRequired(query, addingItems: false)
        lastQueryParameters = query
        
        var result: AnyObject?
        
        lastResultCode = withUnsafeMutablePointer(to: &result) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }
        
        if lastResultCode == noErr { return result as? Data }
        
        return nil
    }
    
    /**
     Retrieves the boolean value from the keychain that corresponds to the given key.
     - parameter key: The key that is used to read the keychain item.
     - returns: The boolean value from the keychain. Returns nil if unable to read the item.
     */
    open func getBool(_ key: String) -> Bool? {
        guard let data = getData(key) else { return nil }
        guard let firstBit = data.first else { return nil }
        return firstBit == 1
    }
    
    /**
     Deletes the single keychain item specified by the key.
     
     - parameter key: The key that is used to delete the keychain item.
     - returns: True if the item was successfully deleted.
     
     */
    @discardableResult
    open func delete(_ key: String) -> Bool {
        let prefixedKey = keyWithPrefix(key)
        
        var query: [String: Any] = [
            KeychainConstant.klass       : kSecClassGenericPassword,
            KeychainConstant.attrAccount : prefixedKey
        ]
        
        query = addAccessGroupWhenPresent(query)
        query = addSynchronizableIfRequired(query, addingItems: false)
        lastQueryParameters = query
        
        lastResultCode = SecItemDelete(query as CFDictionary)
        
        return lastResultCode == noErr
    }
    
    /**
     
     Deletes all Keychain items used by the app. Note that this method deletes all items regardless of the prefix settings used for initializing the class.
     
     - returns: True if the keychain items were successfully deleted.
     
     */
    @discardableResult
    public func clear() -> Bool {
        var query: [String: Any] = [ kSecClass as String : kSecClassGenericPassword ]
        query = addAccessGroupWhenPresent(query)
        query = addSynchronizableIfRequired(query, addingItems: false)
        lastQueryParameters = query
        
        lastResultCode = SecItemDelete(query as CFDictionary)
        
        return lastResultCode == noErr
    }
    
    /// Returns the key with currently set prefix.
    func keyWithPrefix(_ key: String) -> String {
        return "\(keyPrefix)\(key)"
    }
    
    func addAccessGroupWhenPresent(_ items: [String: Any]) -> [String: Any] {
        guard let accessGroup = accessGroup else { return items }
        
        var result: [String: Any] = items
        result[KeychainConstant.accessGroup] = accessGroup
        return result
    }
    
    /**
     
     Adds kSecAttrSynchronizable: kSecAttrSynchronizableAny` item to the dictionary when the `synchronizable` property is true.
     
     - parameter items: The dictionary where the kSecAttrSynchronizable items will be added when requested.
     - parameter addingItems: Use `true` when the dictionary will be used with `SecItemAdd` method (adding a keychain item). For getting and deleting items, use `false`.
     
     - returns: the dictionary with kSecAttrSynchronizable item added if it was requested. Otherwise, it returns the original dictionary.
     
     
     */
    func addSynchronizableIfRequired(_ items: [String: Any], addingItems: Bool) -> [String: Any] {
        if !synchronizable { return items }
        var result: [String: Any] = items
        result[KeychainConstant.attrSynchronizable] = addingItems == true ? true : kSecAttrSynchronizableAny
        return result
    }
}
