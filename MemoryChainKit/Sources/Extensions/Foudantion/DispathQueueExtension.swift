//
//  DispathQueue+After.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/2/24.
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
    class func safeUISync(execute workItem: DispatchWorkItem) {
           if Thread.isMainThread { workItem.perform() }
           else                   { DispatchQueue.main.sync(execute: workItem) }
       }
       
       class func safeUISync<T>(execute work: () throws -> T) rethrows -> T {
           if Thread.isMainThread { return try work() }
           else                   { return try DispatchQueue.main.sync(execute: work) }
       }
       
       class func safeUISync<T>(flags: DispatchWorkItemFlags, execute work: () throws -> T) rethrows -> T {
           if Thread.isMainThread { return try work() }
           else                   { return try DispatchQueue.main.sync(flags: flags, execute: work) }
       }
}
extension DispatchTime {
    /// A convenience method to convert `TimeInterval` to `DispatchTime`.
    ///
    /// - Parameter interval: The time interval, in seconds.
    /// - Returns: A new `DispatchTime` from specified seconds.
    public static func seconds(_ interval: TimeInterval) -> DispatchTime {
        .now() + TimeInterval(Int64(interval * TimeInterval(NSEC_PER_SEC))) / TimeInterval(NSEC_PER_SEC)
    }
}

extension DispatchTime {
    public static func seconds(elapsedSince lastTime: UInt64) -> TimeInterval {
        let currentTime = DispatchTime.now().uptimeNanoseconds
        let oneSecondInNanoseconds = TimeInterval(1_000_000_000)
        let secondsElapsed = TimeInterval(Int64(currentTime) - Int64(lastTime)) / oneSecondInNanoseconds
        return secondsElapsed
    }
    
}
