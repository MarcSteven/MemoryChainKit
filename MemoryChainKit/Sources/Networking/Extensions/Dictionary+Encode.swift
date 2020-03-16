//
//  Dictionary+Encode.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/16.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation

public extension Dictionary where Key:ExpressibleByStringLiteral {
    func urlEncodedString() throws ->String {
        let pairs = try reduce([]) { current, keyValuePair -> [String] in
            if let encodedValue = "\(keyValuePair.value)".addingPercentEncoding(withAllowedCharacters: .urlQueryParametersAllowed) {
                return current + ["\(keyValuePair.key)=\(encodedValue)"]
            } else {
                throw NSError(domain: APIClient.domain, code: 0, userInfo: [NSLocalizedDescriptionKey: "Couldn't encode \(keyValuePair.value)"])
            }
        }

        let converted = pairs.joined(separator: "&")

        return converted

    }
}
