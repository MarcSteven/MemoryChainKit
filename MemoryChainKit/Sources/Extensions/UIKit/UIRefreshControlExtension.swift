//
//  UIRefreshControlExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/9.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import UIKit

extension UIRefreshControl {
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
    
    
}
