//
//  NetworkError.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/14.
//  Copyright © 2020 Marc Steven(.com/MarcSteven). All rights reserved.
//

import Foundation

/**
 Network Error is the memoryChainError implementation of error type
 */

public enum NetworkError:MemoryChainError,Equatable {
    case parameterEncoding(Any)
    case multipartEncoding(Any)
    case jsonDeserialalization
    case emptyResponse
    case statusCode(Int)
    case invalidURL(String)
    case notHTTPResponse
    case jsonMapping(Any)
    case unknown(String)
    
    public var description: String {
        switch self {
        case .parameterEncoding(let value):
            return "An error occurred while encoding parameter:\(value)"
        case .jsonDeserialalization:
            return "cannot parse data to JSON"
        case .statusCode(let code):
            return "HTTP Error occured with code: \(code)"
        case .emptyResponse:
            return "tried to deserialize response, but no data was found"
        case .invalidURL(let url):
            return "provided url is not valid :\(url)"
        case .jsonMapping(let object):
            return "Could not map json object to object, json:\(object)"
        case .unknown(let description):
            return description
        case .multipartEncoding(let value):
            return "An error occurred while encoding parameter:\(value)"
        
        case .notHTTPResponse:
            return "Response was not an HTTP response"
        }
    }
    /**
        convenience method that will transform on error
     */
    static func error(with error:Error?) ->NetworkError {
        return  NetworkError.unknown(error?.localizedDescription ?? "")
    }
    /** convenience method that create a http error with a status code*/
    
    static func error(with statusCode:Int) ->NetworkError {
        return .statusCode(statusCode)
    }
    public static func ==(lhs:NetworkError,rhs:NetworkError) ->Bool {
        switch lhs {
        case .parameterEncoding:
            if case .parameterEncoding = rhs { return true }
        case .multipartEncoding:
            if case .multipartEncoding = rhs { return true }
        case .emptyResponse:
            if case .emptyResponse = rhs { return true }
        case .statusCode(let codeA):
            if case .statusCode(let codeB) = rhs { return codeA == codeB}
        case .unknown:
            if case .unknown = rhs { return true }
        case .jsonDeserialalization:
            if case .jsonDeserialalization = rhs { return true }
        case .invalidURL:
            if case .invalidURL = rhs { return true }
        case .notHTTPResponse:
            if case .notHTTPResponse = rhs { return true }
        case .jsonMapping:
            if case .jsonMapping = rhs { return true }
        }
        return false
    }
}
