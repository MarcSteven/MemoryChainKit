//
// Timer.swift
//
// MemoryChainKit
// Copyright (C) 2020 Marc Steven <https://marcsteven.top>

import Foundation

/**
 Implementation of timer for easier use. It is based on NSTimer/
 */
open class Timer: NSObject {
    
    /// Interval set for this timer
    public let timeout: TimeInterval;
    fileprivate var timer: Foundation.Timer?
    /// Callback execute when timer is fired
    open var callback: (() ->Void)?
    /// True if timer is repeating execution many times
    public let repeats:Bool;
    
    /**
     Creates instance of Timer
     - parameter delayInSeconds: delay after which callback should be executed
     - parameter repeats: true if timer should be fired many times
     - parameter callback: executed when timer is fired
     */
    public init(delayInSeconds: TimeInterval, repeats: Bool, callback: @escaping ()->Void) {
        self.timeout = delayInSeconds;
        self.callback = callback;
        self.repeats = repeats;
        super.init();
        DispatchQueue.main.async {
            self.timer = Foundation.Timer.scheduledTimer(timeInterval: delayInSeconds, target: self, selector: #selector(Timer.execute), userInfo: nil, repeats: repeats);
        }
    }
    
    /**
     Method fire by NSTimer internally
     */
    @objc open func execute() {
        callback?();
        if !repeats {
            cancel();
        }
    }
    
    /**
     Methods cancels timer
     */
    open func cancel() {
        callback = nil;
        DispatchQueue.main.async {
            self.timer?.invalidate()
            self.timer = nil;
        }
    }
}
