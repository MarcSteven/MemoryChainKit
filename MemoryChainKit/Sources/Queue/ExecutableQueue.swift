//
//  ExecutableQueue.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/19.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation
import Dispatch


public protocol ExecutableQueue {
    var queue:DispatchQueue {get}
    func execute(_ mode :ExecutableQueueMode,block:()->())
}


