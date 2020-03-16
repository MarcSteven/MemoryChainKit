//
//  Int+StatusCode.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/16.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation

public extension Int {
    var statusCodeType:StatusCodeType {
        switch self {
        case URLError.cancelled.rawValue:
            return .cancelled
        case 100..<200:
            return .informational
        case 200..<300:
            return .success
        case 300..<400:
            return .redirection
        case 400..<500:
            return .clientError
        case 500..<600:
            return .serverError
        default:
            return .unknown
        }
    }
}
