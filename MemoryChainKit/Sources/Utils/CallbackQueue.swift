//
//  CallbackQueue.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2023/11/2.
//  Copyright © 2023 Marc Steven(https://.com/MarcSteven). All rights reserved.
//

import Foundation


public enum CallbackQueue {
    case asyncMain
    case currentMainOrAsync
    case untouch
    case dispathc(DispatchQueue)
    case operation(OperationQueue)
    
    func execute(_ block:@escaping () ->Void) {
        switch self {
        case .asyncMain:
            DispatchQueue.main.async {
                block()
            }
        case .currentMainOrAsync:
            DispatchQueue.main.safeAsync {
                block()
            }
        case .untouch:
            block()
        case .dispathc(let queue):
            queue.async {
                block()
            }
        case .operation(let queue):
            queue.addOperation {
                block()
            }
        
        }
    }
}
extension DispatchQueue {
    func safeAsync(_ block:@escaping () ->()) {
        if self == DispatchQueue.main && Thread.isMainThread {
            block()
        }else {
            async {
                block()
            }
        }
    }
}
