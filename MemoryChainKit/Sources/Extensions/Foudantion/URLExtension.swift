//
//  URLExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/9.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation

extension URL {
    public init?(string: String, queryParameters: [String: String]) {
        var components = URLComponents(string: string)
        components?.queryItems = queryParameters.map(URLQueryItem.init)

        guard let string = components?.url?.absoluteString else {
            return nil
        }

        self.init(string: string)
    }
}


// MARK: - Scheme

extension URL {
    /// The scheme of the `URL`.
    public var schemeType: Scheme {
        guard let scheme = scheme else {
            return .none
        }

        return Scheme(rawValue: scheme)
    }
}

extension URL {
    public struct Scheme: RawRepresentable, Hashable, CustomStringConvertible {
        public let rawValue: String

        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        public var description: String {
            rawValue
        }
    }
}

extension URL.Scheme: ExpressibleByStringLiteral {
    public init(stringLiteral value: StringLiteralType) {
        self.rawValue = value
    }
}

extension URL.Scheme {
    public static let none: Self = ""
    public static let https: Self = "https"
    public static let http: Self = "http"
    public static let file: Self = "file"
    public static let tel: Self = "tel"
    public static let sms: Self = "sms"
    public static let email: Self = "mailto"
}
