//
//  DispatchQueueExtension.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2020/3/12.
//  Copyright © 2020 Marc Zhao(https://github.com/MarcSteven). All rights reserved.
//

import Foundation


public func ensureMainThread(execute work:@escaping @convention(block)() ->Void) {
    if Thread.isMainThread {
        work()
    }else {
        DispatchQueue.main.async {
            work()
        }
    }
}
public func asyncMain(_ block:(() ->Void)?) {
    DispatchQueue.main.async {
        block()
    }
}
public func asyncMainDelay(duration:TimeInterval = 1,
                           block:@escaping (()->Void)?) {
    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
        block()
    }
}
