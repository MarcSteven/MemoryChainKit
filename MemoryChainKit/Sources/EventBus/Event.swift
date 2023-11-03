//
//  Event.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/24.
//  Copyright © 2020 Marc Steven(.com/MarcSteven). All rights reserved.
//

import Foundation

/** Event bus
 */
public protocol Event:AnyObject {
    
    var type:String {get}
    
}
public protocol SerialEvent {}


public func ==(lhs:Event,rhs:Event) ->Bool {
    return lhs == rhs || lhs.type == rhs.type
}
public func == (lhs:[Event],rhs:[Event]) ->Bool {
    guard lhs.count == rhs.count else {
        return false
    }
    for le in lhs {
        if rhs.contains(where: {(re) ->Bool in
            return le == re
        }) {
            
        }else {
            return false
        }
    }
    return true
}
