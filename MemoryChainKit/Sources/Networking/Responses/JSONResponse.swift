//
//  JSONResponse.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/16.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation

public class JSONResponse: HTTPResponse {
    let json: JSONType

    public var dictionaryBody: [String: Any] {
        return json.dictionary
    }

    public var arrayBody: [[String: Any]] {
        return json.array
    }

    public var data: Data {
        switch json {
        case let .array(value, _):
            return value
        case let .dictionary(value, _):
            return value
        case .none:
            return Data()
        }
    }

    init(json: JSONType, response: HTTPURLResponse) {
        self.json = json

        super.init(response: response)
    }
}
