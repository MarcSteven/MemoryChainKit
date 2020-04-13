//
//  Timer+Extension.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/1/23.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation

extension  Timer {
    @discardableResult
    class func schedule(delay:TimeInterval,handler:@escaping () ->Void) ->Timer! {
        let fireDate = delay + CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, 0, 0, 0) { _ in
            handler()
        }
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
        return timer!

    }
    @discardableResult
    class func schedule(repeatInterval interval:TimeInterval,handler:@escaping ()->Void) ->Timer {
        let fireDate = interval + CFAbsoluteTimeGetCurrent()
               let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, interval, 0, 0) { _ in
                   handler()
               }
               CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
               return timer!
    }
    public class func schedule(repeatInterval interval:TimeInterval,
                               _ handler:@escaping () ->Void) ->Timer {
        let fireDate = interval + CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, interval, 0, 0) {_ in
            handler()
        }
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
        return timer!
    }
}

extension Timer {
    private struct AssociatedKey {
        static var timerPauseDate = "timerPauseDate"
        static var timePreviousFireDate = "timerPreviousFireDate"
    }
    private var pauseDate:Date? {
        get {
            objc_getAssociatedObject(self, &AssociatedKey.timerPauseDate) as? Date
            
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.timerPauseDate, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    private var previousFireDate:Date? {
        get {
            objc_getAssociatedObject(self, &AssociatedKey.timePreviousFireDate) as? Date
            
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.timePreviousFireDate, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    public func pause() {
        pauseDate = Date()
        previousFireDate = fireDate
        fireDate = Date.distantFuture
    }
    public func resume() {
        guard let pauseDate = pauseDate,let previousFireDate = previousFireDate else {
            return
        }
        fireDate = Date(timeInterval: -pauseDate.timeIntervalSinceNow, since: previousFireDate)
    }

}

