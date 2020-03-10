//
//  DispatchQueue+IsMainThread.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/2/16.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation
public typealias Closure = () ->Void
public extension DispatchQueue {
    static func isExecutedOnMainThread(_ closure:@escaping Closure ) {
        if Thread.isMainThread {
            closure()
        }else {
            main.async(execute: closure)
        }
    }
}
