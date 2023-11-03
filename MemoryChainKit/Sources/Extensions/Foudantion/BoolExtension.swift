//
//  BoolExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/11/9.
//  Copyright © 2020 Marc Steven(https://.com/MarcSteven). All rights reserved.
//

import Foundation

public extension Bool {
//    convert bool to int
    var toInt:Int {
        return self ? 1 : 0
    }
    // convert bool to string 
    var toString:String {
        return self ? "true" : "false"
    }
}
