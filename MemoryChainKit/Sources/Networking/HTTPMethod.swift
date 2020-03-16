//
//  HTTPMethod.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/16.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation

public struct HTTPMethod:RawRepresentable,Equatable,Hashable {
    public static let connect = HTTPMethod(rawValue: "CONNECT")
    public static let get = HTTPMethod(rawValue: "GET")
    public static let post = HTTPMethod(rawValue: "POST")
    public static let put = HTTPMethod(rawValue: "PUT")
    public static let delete = HTTPMethod(rawValue: "DELETE")
    public static let update = HTTPMethod(rawValue: "UPDATE")
    public static let patch = HTTPMethod(rawValue: "PATCH")
    
    public let rawValue: String
    public init(rawValue:String) {
        self.rawValue = rawValue
    }
}

