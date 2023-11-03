//
//  UIRefreshControlExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/9.
//  Copyright © 2020 Marc Steven(.com/MarcSteven). All rights reserved.
//

import UIKit

public extension UIRefreshControl {
    private struct AssociatedKey {
        static var timeOutTimer = "timeOutTimer"
    }
    private var timeoutTimer:Timer? {
        get {
            objc_getAssociatedObject(self, &AssociatedKey.timeOutTimer) as? Timer
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.timeOutTimer, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// Tells the control that a refresh operation has ended.
    ///
    /// Call this method at the end of any refresh operation (whether it was initiated
    /// programmatically or by the user) to return the refresh control to its default state.
    /// If the refresh control is at least partially visible, calling this method also hides
    /// it. If animations are also enabled, the control is hidden using an animation.
    ///
    /// - Parameters:
    ///   - timeoutInterval: The delay before end refreshing.
    ///   - completion: A closure to execute after end refreshing.
     func endRefreshing(after timeoutInterval: TimeInterval, completion: (() -> Void)? = nil) {
        timeoutTimer?.invalidate()
        timeoutTimer = Timer.schedule(delay: timeoutInterval) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.endRefreshing()
            completion?()
        }
    }

}
