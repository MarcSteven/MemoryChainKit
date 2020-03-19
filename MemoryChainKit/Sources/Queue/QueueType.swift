//
//  QueueType.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/19.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation

public enum QueueType {
    case serial, concurrent
    
}

extension QueueType :CustomStringConvertible {
    public var description: String {
        switch self {
        case .serial:
            return "serial"
        case .concurrent:
            return "concurrent"
        
        }
    }
}
