//
//  UIPressExtension.swift
//  MemoryChainKit
//
//  Created by MarcSteven on 2021/12/22.
//  Copyright © 2021 Marc Steven(https://.com/MarcSteven). All rights reserved.
//

import UIKit

public extension UIPress.Phase {
    var isStartingPhase:Bool {
        return self == .began
    }
    var isTerminatingPhase:Bool {
        return self == .cancelled || self == .ended
    }
}
