//
//  HTTPMethod.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/16.
//  Copyright © 2020 Marc Steven(.com/MarcSteven). All rights reserved.
//

import Foundation


/**
 HTTP method definitions.
 See https://tools.ietf.org/html/rfc7231#section-4.3
 */
public enum HTTPMethod: String {
    case options, get, head, post, put, patch, delete, trace, connect
}
