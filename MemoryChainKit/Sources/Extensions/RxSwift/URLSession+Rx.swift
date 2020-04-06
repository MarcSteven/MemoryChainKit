//
//  URLSession+Rx.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/6.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON
import UIKit


fileprivate var internalCache = [String:Data]()

public enum URLSessionError:Error {
    case unknown
    case invalidResponse(response:URLResponse)
    case requestFailed(response:HTTPURLResponse,data:Data)
    case deserializationFailed
    
    
}
extension ObservableType where Element == (HTTPURLResponse,Data) {
    public func cache() ->Observable<Element> {
        return self.do(onNext: {(response,data)in
            if let url = response.url?.absoluteString, 200..<300 ~= response.statusCode {
                internalCache[url] = data
                
            }
        })
        
    }
}

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
        public func response(request:URLRequest) ->Observable<(HTTPURLResponse,Data)> {
        return Observable.create {observer in
            let task = self.base.dataTask(with: request) {(data,response,error)in
                guard let response = response,let data = data else {
                    observer.onError(error ?? URLSessionError.unknown)
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse else {
                    observer.onError(URLSessionError.invalidResponse(response: response))
                    return
                }
                observer.onNext((httpResponse,data))
                observer.onCompleted()
            }
            task.resume()
            return Disposables.create(with: task.cancel)
        }
    }
    public func data(request:URLRequest) ->Observable<Data> {
        if let url = request.url?.absoluteString,let data = internalCache[url] {
            return Observable.just(data)
        }
        return response(request: request).cache().map {(response,data)->Data in
            if 200..<300 ~= response.statusCode {
                return data
            }else {
                throw URLSessionError.requestFailed(response: response,data:data)
            }
        }
    }
//    public func response(request:URLRequest) ->Observable<Data> {
//        if let url = request.url?.absoluteString, let data = internalCache[url] {
//            return Observable.just(data)
//        }
//    }
    
    public func string(request:URLRequest) ->Observable<String> {
        return data(request: request).map{d in
            return String(data: d, encoding: .utf8) ?? ""
        }
    }
    public func json(request:URLRequest) ->Observable<JSON> {
        return data(request: request).map{data in
            return try JSON(data: data)
        }
    }
    public func image(request:URLRequest) ->Observable<UIImage> {
        return data(request: request).map{ data in
            return UIImage(data: data) ?? UIImage()
        }
    }
}
