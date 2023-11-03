//
//  CharacterSet+URLQueryParameters.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/16.
//  Copyright © 2020 Marc Steven(.com/MarcSteven). All rights reserved.
//

import Foundation

public extension CharacterSet {
    static var urlQueryParametersAllowed: CharacterSet {
        /// Does not include "?" or "/" due to RFC 3986 - Section 3.4
        let generalDelimitersToEncode = ":#[]@"
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowedCharacterSet = CharacterSet.urlQueryAllowed
        allowedCharacterSet.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")

        return allowedCharacterSet
    }
}
