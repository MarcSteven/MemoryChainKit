//
//  ExecutableQueueMode.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/19.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation

public enum ExecutableQueueMode {
    case async,sync
}
extension ExecutableQueueMode:CustomStringConvertible {
    public var description: String {
        switch self {
        case .async:
            return "async"
        case .sync:
            return "sync"
        }
    }
}
