//
//  UIGestureRecognizer+Extension.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/11/25.
//  Copyright © 2019 Memory Chain network technology(China) co,LTD. All rights reserved.
//

import UIKit

public extension UIGestureRecognizer.State {
    var isStartingState:Bool {
        return self == .began
    }
    var isTerminatingState:Bool {
        return self == .cancelled || self == .ended || self == .failed
    }
}
