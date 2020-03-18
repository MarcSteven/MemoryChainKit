//
//  Environment.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/18.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//


import Foundation

extension Environment {
    public enum Kind: CustomStringConvertible {
        case development
        case staging
        case production

        public var description: String {
            switch self {
                case .development:
                    return "Development"
                case .staging:
                    return "Staging"
                case .production:
                    return "Production"
            }
        }
    }
}

open class Environment {
    open var kind: Kind = .production

    public init() { }
}
