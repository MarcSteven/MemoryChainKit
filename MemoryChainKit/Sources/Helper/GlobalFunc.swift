//
//  GlobalFunc.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/8.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation

public func unsafePointer<T:AnyObject>(to object:T) ->UnsafeRawPointer {
    return UnsafeRawPointer(Unmanaged<T>.passUnretained(object).toOpaque())
}
public func unsafeMutablePointer<T:AnyObject>(to object:T)->UnsafeMutableRawPointer {
    return Unmanaged<T>.passUnretained(object).toOpaque()
}
/// Detects if the LLDB debugger is attached to the app.
///
/// - Note: LLDB is automatically attached when the app is running from Xcode.
public var isDebuggerAttached: Bool {
    var info = kinfo_proc()
    var mib: [Int32] = [CTL_KERN, KERN_PROC, KERN_PROC_PID, getpid()]
    var size = MemoryLayout<kinfo_proc>.stride
    let junk = sysctl(&mib, UInt32(mib.count), &info, &size, nil, 0)
    assert(junk == 0, "sysctl failed")
    return (info.kp_proc.p_flag & P_TRACED) != 0
}

public func synchronized<T>(_ lock: AnyObject, _ closure: () throws -> T) rethrows -> T {
    objc_sync_enter(lock)
    defer { objc_sync_exit(lock) }
    return try closure()
}
