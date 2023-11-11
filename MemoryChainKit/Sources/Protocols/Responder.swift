//
//  Responder.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/2/9.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit
public protocol Responder:AnyObject {
    
}
public protocol Dispatcher {
    typealias Event = UIEvent
    func dispatch(_ event:Event)
}
