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

public extension URL {
    /// The scheme of the `URL`.
     var schemeType: Scheme {
        guard let scheme = scheme else {
            return .none
        }

        return Scheme(rawValue: scheme)
    }
}
public extension URL {
    func queryStringComponents() -> [String: AnyObject] {

        var dict = [String: AnyObject]()

        // Check for query string
        if let query = self.query {

            // Loop through pairings (separated by &)
            for pair in query.components(separatedBy: "&") {

                // Pull key, val from from pair parts (separated by =) and set dict[key] = value
                let components = pair.components(separatedBy: "=")
                if (components.count > 1) {
                    dict[components[0]] = components[1] as AnyObject?
                }
            }

        }

        return dict
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


public struct MailToMetaData {
    public let to:String
    public let headers:[String:String]
}
public extension URL {
    func mailToMetaData() ->MailToMetaData? {
        guard scheme == "mailto",let components = URLComponents(url: self, resolvingAgainstBaseURL: false) else {
            return nil
        }
        let toMail = components.path
        let queryItems = components.queryItems
        var headers = [String:String]()
        guard let queryItems = queryItems else {
            if toMail.isEmpty {
                return nil
            }
            return MailToMetaData(to: toMail, headers: headers)
        }
        queryItems.forEach{ queryItem in guard let value = queryItem.value else {return}
            headers[queryItem.name] = value
        }
        return MailToMetaData(to: toMail, headers: headers)
    }
}
