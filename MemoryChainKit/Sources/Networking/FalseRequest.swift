//
//  FalseRequest.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/16.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation

struct FalseRequest {
    let response: Any?
    let responseType: ResponseType
    let statusCode: Int

    static func find(ofType type: HTTPMethod, forPath path: String, in collection: [HTTPMethod: [String: FalseRequest]]) -> FalseRequest? {
        guard let requests = collection[type] else { return nil }

        guard path.count > 0 else { return nil }
        var evaluatedPath = path
        evaluatedPath.removeFirstLetterIfDash()
        evaluatedPath.removeLastLetterIfDash()
        let lookupPathParts = evaluatedPath.components(separatedBy: "/")

        for (originalFakedPath, fakeRequest) in requests {
            switch fakeRequest.responseType {
            case .data, .image:
                if originalFakedPath == path {
                    return fakeRequest
                } else {
                    return nil
                }
            case .json:
                if let response = fakeRequest.response {
                    var fakedPath = originalFakedPath
                    fakedPath.removeFirstLetterIfDash()
                    fakedPath.removeLastLetterIfDash()
                    let fakePathParts = fakedPath.components(separatedBy: "/")
                    guard lookupPathParts.count == fakePathParts.count else { continue }
                    guard lookupPathParts.first == fakePathParts.first else { continue }
                    guard lookupPathParts.count != 1 && fakePathParts.count != 1 else { return requests[originalFakedPath] }

                    var replacedValues = [String: String]()
                    for (index, fakePathPart) in fakePathParts.enumerated() {
                        if fakePathPart.contains("{") {
                            replacedValues[fakePathPart] = lookupPathParts[index]
                        }
                    }

                    var responseString = String(data: try! JSONSerialization.data(withJSONObject: response, options: .prettyPrinted), encoding: .utf8)!
                    for (key, value) in replacedValues {
                        responseString = responseString.replacingOccurrences(of: key, with: value)
                    }
                    let stringData = responseString.data(using: .utf8)
                    let finalJSON = try! JSONSerialization.jsonObject(with: stringData!, options: [])

                    return FalseRequest(response: finalJSON, responseType: fakeRequest.responseType, statusCode: fakeRequest.statusCode)
                } else if originalFakedPath == path {
                    return fakeRequest
                } else {
                    return nil
                }
            }
        }

        let result = requests[path]

        return result
    }
}

