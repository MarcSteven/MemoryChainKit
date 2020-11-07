//
//  Decoding.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/24.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation


extension Dictionary where Key : StringProtocol {
    /// Generically decode an value from a given JSON dictionary.
    ///
    /// - parameter key: key in the dictionary
    /// - returns: The expected value
    /// - throws: JSONDeserializationError
    public func decode<T>(key: Key) throws -> T {
        guard let value = self[key] else {
            throw JSONDeserializationError.missingAttribute(key: String(key))
        }

        guard let attribute = value as? T else {
            throw JSONDeserializationError.invalidAttributeType(key: String(key), expectedType: T.self,
                                                                receivedValue: value)
        }

        return attribute
    }

    /// Decode a JSONDeserializable type from a given JSON dictionary.
    ///
    /// - parameter key: key in the dictionary
    /// - returns: The expected JSONDeserializable value
    /// - throws: JSONDeserializationError
    public func decode<T: JSONDeserializable>(key: Key) throws -> T {
        let json: JSON = try decode(key: key)
        return try T.init(json: json)
    }

    /// Decode an array of JSONDeserializable types from a given JSON dictionary.
    ///
    /// - parameter key: key in the dictionary
    /// - returns: The expected JSONDeserializable value
    /// - throws: JSONDeserializationError
    public func decode<T: JSONDeserializable>(key: Key) throws -> [T] {
        let values: [JSON] = try decode(key: key)
        return try values.compactMap { try T.init(json: $0) }
    }
}

extension Dictionary where Key : StringProtocol {
    /// Decode a `RawRepresentable` enum value from a given JSON dictionary.
    ///
    /// - parameter key: key in the dictionary
    /// - returns: The expected value
    /// - throws: JSONDeserializationError
    public func decode<T: RawRepresentable>(key: Key) throws -> T {
        let string: T.RawValue = try decode(key: key)

        guard let value = T(rawValue: string) else {
            throw JSONDeserializationError.invalidAttributeType(key: String(key), expectedType: T.RawValue.self,
                                                                receivedValue: string)
        }

        return value
    }
}
extension Dictionary where Key : StringProtocol {
    /// Decode a date value from a given JSON dictionary. ISO8601 or Unix timestamps are supported.
    ///
    /// - parameter key: key in the dictionary
    /// - returns: The expected value
    /// - throws: JSONDeserializationError
    public func decode(key: Key) throws -> Date {
        let value: Any = try decode(key: key)

        if #available(OSXApplicationExtension 10.12, iOSApplicationExtension 10.0, watchOSApplicationExtension 3.0,
            tvOSApplicationExtension 10.0, *), let string = value as? String
        {
            guard let date = ISO8601DateFormatter().date(from: string) else {
                throw JSONDeserializationError.invalidAttribute(key: String(key))
            }

            return date
        }

        if let timeInterval = value as? TimeInterval {
            return Date(timeIntervalSince1970: timeInterval)
        }

        if let timeInterval = value as? Int {
            return Date(timeIntervalSince1970: TimeInterval(timeInterval))
        }

        throw JSONDeserializationError.invalidAttributeType(key: String(key), expectedType: String.self,
                                                            receivedValue: value)
    }
}

extension Dictionary where Key : StringProtocol {
    /// Decode a URL value from a given JSON dictionary.
    ///
    /// - parameter key: key in the dictionary
    /// - returns: The expected value
    /// - throws: JSONDeserializationError
    public func decode(key: Key) throws -> URL {
        let string: String = try decode(key: key)

        guard let url = URL(string: string) else {
            throw JSONDeserializationError.invalidAttributeType(key: String(key), expectedType: URL.self,
                                                                receivedValue: string)
        }

        return url
    }
}
