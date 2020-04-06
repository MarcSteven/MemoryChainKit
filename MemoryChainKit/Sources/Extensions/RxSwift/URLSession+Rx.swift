//
//  URLSession+Rx.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/6.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


public enum StatusCodeError:Swift.Error {
    case code(Int)
    public var code:Int {
        switch self {
        case let .code(code):
            return code
    
        }
    }
}
extension StatusCodeError:LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .code(code):
            return "error code is \(code)"
        
        
        }
    }
}

extension Reactive where Base:URLSession {
    public func statusCode(_ url:URL) ->Observable<Int> {
        return response(request: URLRequest(url: url))
            .map { (response,data) -> Int in
                if 200..<300 ~= response.statusCode {
                    return response.statusCode
                }
                else {
                    throw StatusCodeError.code(response.statusCode)
                }
        }
    }
}
