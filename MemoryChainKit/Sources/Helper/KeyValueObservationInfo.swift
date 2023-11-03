//
//  KeyValueObservationInfo.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/8.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation


public struct KeyValueObservationInfo {
    private(set) var observed:NSObject?
    private(set) var keyPath:String?
}

open class KeyValueObservationProxy:NSObject {
//MARK: - Properties

weak var observed: NSObject?
var keyPath: String!
var handler: ((NSObject, String, [NSKeyValueChangeKey : Any]?) -> Void)!

//MARK: - Initialization

init(observed: NSObject, keyPath: String, options: NSKeyValueObservingOptions, handler: @escaping (NSObject, String, [NSKeyValueChangeKey : Any]?) -> Void) {
    self.observed = observed
    self.keyPath  = keyPath
    self.handler  = handler
    super.init()
    
    observed.addObserver(self, forKeyPath: keyPath, options: options, context: nil)
}

deinit {
    if let observed = observed {
        observed.removeObserver(self, forKeyPath: keyPath, context: nil)
    }
}

//MARK: - KVO Methods

    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    handler(observed ?? object as! NSObject, self.keyPath, change)
}
}
