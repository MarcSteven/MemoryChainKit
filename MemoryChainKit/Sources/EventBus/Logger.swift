//
//  Logger.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/24.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation


/**
 Custom structure used as logging utility to log entries with timestamps
 and other additional data for easier analysis of logs.
 
 It is required to initialize this utility class before it is used
 by calling:
 ```
    Log.initialize();
 ```
 */
public struct Log {
    
    fileprivate static let dateFormatter = DateFormatter();
    
    /// Method to initialize this mechanism
    public static func initialize() {
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS";
        
    }
    
    /**
     Methods logs items passed.
     - parameter items: items to log
     - parameter from: source of this entry
     */
    public static func log(_ items: Any?..., from: Any? = nil) {
        #if !DISABLE_LOG
            logInternal(items, from: from)
        #endif
    }
    
    /**
     Methods logs items passed.
     - parameter items: items to log
     - parameter from: source of this entry
     */
    static func logInternal<T>(_ items: [T?], from: Any? = nil) {
        #if !DISABLE_LOG
            let date = Date();
            let prefix = dateFormatter.string(from: date);
            var entry = prefix + " ";
            if (from != nil) {
                entry +=  "\(from!) ";
            }
            entry += (items.map({ it in
                return it == nil ? "nil" : "\(it!)";
            }).joined(separator: " "));
            print(entry)
        #endif
    }
    
}

/**
 Class which is used by many TigaseSwift classes for easier logging.
 When other classes extends it, it adds a `log(items: Any..)` method
 which provides this extending class as source of this log entry.
 */
open class Logger {
    
    public init() {
        
    }
    
    /**
     Method logs entry with providing `self.dynamicType` as source
     of this entry log.
     - parameter items: items to add to log
     */
    open func log(_ items: Any?...) {
        #if !DISABLE_LOG
            Log.logInternal(items, from: type(of: self))
        #endif
    }
}

/// Extension of NSObject to provide support for TigaseSwift logging feature
extension NSObject {

    /**
     Method logs entry with providing `self.dynamicType` as source
     of this entry log.
     - parameter items: items to add to log
     */
    public func log(_ items: Any?...) {
        #if !DISABLE_LOG
            Log.logInternal(items, from: type(of: self))
        #endif
    }
    
}
