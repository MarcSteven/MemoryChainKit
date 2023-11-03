//
//  ParameterEncoding.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/17.
//  Copyright © 2020 Marc Steven(.com/MarcSteven). All rights reserved.
//

import Foundation

/**
 ParameterEncoding is an Enum that defines how the parameters will be encoded in the request
 */
public enum ParameterEncoding {

    /**
     url encoding will append the parameter in the url as query parameters.
     For instance if parameters are ["foo":"bar","test":123] url will look something like https://my-website.com/api/path?foo=bar&test=123
    */
    case url

    /**
     json encoding will serialize the parameters in JSON and put them in the body of the request
    */
    case json

    /**
     form encoding will url encode the parameters and put them in the body of the request
    */
    case form
}

/**
 URLRequest extension that allows us to encode the parameters directly in the request
 */
extension URLRequest {

    /**
     Mutating function that, with a given set of parameters, will take care of building the request
     It is a mutating function and has side effects, it will modify the headers, the body and the url of the request.
     Make sure that this function not called after setting one of the above, or they might be overriden.
     - parameter parameters: A dictionary that needs to be encoded
     - parameter encoding: The encoding in which the parameters should be encoded
    */
    mutating func encode(parameters: [String: Any]?, encoding: ParameterEncoding) throws {
        guard let parameters = parameters else {return}

        switch encoding {
        case .url:
            guard let url = self.url else {return}
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
            if urlComponents != nil && !parameters.isEmpty {
                let paramString = (parameters.map { "\($0)=\($1)" } as [String]).joined(separator: "&")
                let percentEncodedQuery = (urlComponents!.percentEncodedQuery.map { $0 + "&" } ?? "") + paramString
                urlComponents!.percentEncodedQuery = percentEncodedQuery
                self.url = urlComponents!.url
            }
        case .json:
            do {
                let data = try JSONSerialization.data(withJSONObject: parameters, options: [])
                self.httpBody = data
                self.setValue("application/json", forHTTPHeaderField: "Content-Type")
            } catch {
                throw NetworkError.parameterEncoding(parameters)
            }
        case .form:
            let paramString = (parameters.map { "\($0)=\($1)" } as [String]).joined(separator: "&")
            self.httpBody = paramString.data(using: String.Encoding.utf8, allowLossyConversion: false)
            self.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
    }

    mutating func encode(form: MultipartForm) throws {
        self.httpBody = try form.encode()
        self.setValue("multipart/form-data; boundary=\(form.boundary)", forHTTPHeaderField: "Content-Type")
    }
}
