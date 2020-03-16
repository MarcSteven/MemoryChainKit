//
//  Result.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/16.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation


public protocol Result {
    init(body: Any?, response: HTTPURLResponse, error: NSError?)
}

public enum GenericResult<T> {
    case success(T)
    case failure(FailureJSONResponse)
}

public enum VoidResult {
    case success
    case failure(FailureJSONResponse)
}

public enum JSONResult: Result {
    case success(SucessfulJSONResponse)

    case failure(FailureJSONResponse)

    public var error: NSError? {
        switch self {
        case .success:
            return nil
        case let .failure(response):
            return response.error
        }
    }

    public init(body: Any?, response: HTTPURLResponse, error: NSError?) {
        var returnedError = error
        var json = JSONType.none

        if let dictionary = body as? [String: Any] {
            json = JSONType(dictionary)
        } else if let array = body as? [[String: Any]] {
            json = JSONType(array)
        } else if let data = body as? Data, data.count > 0 {
            do {
                json = try JSONType(data)
            } catch let JSONParsingError as NSError {
                if returnedError == nil {
                    returnedError = JSONParsingError
                }
            }
        }

        if let finalError = returnedError {
            self = .failure(FailureJSONResponse(json: json, response: response, error: finalError))
        } else {
            self = .success(SucessfulJSONResponse(json: json, response: response))
        }
    }
}

public enum ImageResult: Result {
    case success(SuccessImageResponse)

    case failure(FailureResponse)

    public init(body: Any?, response: HTTPURLResponse, error: NSError?) {
        let image = body as? Image
        if let error = error {
            self = .failure(FailureResponse(response: response, error: error))
        } else if let image = image {
            self = .success(SuccessImageResponse(image: image, response: response))
        } else {
            let error = NSError(domain: APIClient.domain, code: URLError.cannotParseResponse.rawValue, userInfo: [NSLocalizedDescriptionKey: "Malformed image"])
            self = .failure(FailureResponse(response: response, error: error))
        }
    }
}

public enum DataResult: Result {
    case success(SuccessDataResponse)

    case failure(FailureResponse)

    public init(body: Any?, response: HTTPURLResponse, error: NSError?) {
        let data = body as? Data
        if let error = error {
            self = .failure(FailureResponse(response: response, error: error))
        } else if let data = data {
            self = .success(SuccessDataResponse(data: data, response: response))
        } else {
            let error = NSError(domain: APIClient.domain, code: URLError.cannotParseResponse.rawValue, userInfo: [NSLocalizedDescriptionKey: "Malformed data"])
            self = .failure(FailureResponse(response: response, error: error))
        }
    }
}
