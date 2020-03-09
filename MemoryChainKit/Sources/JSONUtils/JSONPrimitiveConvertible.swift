//
//  JSONPrimitiveConvertible.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2018/12/28.
//  Copyright © 2018 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation

public protocol JSONPrimitiveConvertible {
    associatedtype JSONType:JSONRawType
    
    //associatetype JSONType:JSONRawType
    static func from(jsonValue:JSONType) ->Self?
}
