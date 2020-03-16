//
//  ResponseType.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/16.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation

public enum ResponseType {
    case json,data,image
    var accept:String? {
        switch self {
        case .json:
            return "application/json"
        
        default:
            return nil
        }
    }
}
