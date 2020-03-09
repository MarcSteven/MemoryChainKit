//
//  Observer.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/10/11.
//  Copyright © 2019 Memory Chain network technology(China) co,LTD. All rights reserved.
//

import Foundation


public protocol Observer {
    
    func startObserving()
    func stopObserving()
}
