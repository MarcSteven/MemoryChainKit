//
//  ParametersType.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/16.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation


public enum ParameterType {
    case none,json,formURLEncoded,multiPartFormData,custom(String)
    func contentType(_ boundary:String) ->String? {
        switch self {
        case .none:
            return nil
        case .json:
            return "application/json"
        case .formURLEncoded:
            return "application/x-www-form-urlencoded"
        case .multiPartFormData:
            return "multipart/form-data; boundary=\(boundary)"
        case .custom(let value):
            return value
        }
    }
}
