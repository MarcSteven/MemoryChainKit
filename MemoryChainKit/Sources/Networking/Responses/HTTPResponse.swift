//
//  HTTPResponse.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/16.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation

public class HTTPResponse {
    var headers:[AnyHashable:Any] {
        return fullResponse.allHeaderFields
    }
    var statusCode:Int {
        return fullResponse.statusCode
    }
    let fullResponse:HTTPURLResponse
    init(response:HTTPURLResponse) {
        fullResponse = response
    }
}
