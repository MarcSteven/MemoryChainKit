//
//  DispathQueue+After.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/2/24.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation


public extension DispatchQueue {
    func after(_ delay:TimeInterval,execute closure:@escaping () ->Void ) {
        asyncAfter(deadline: .now() + delay, execute: closure)
    }
    
}
