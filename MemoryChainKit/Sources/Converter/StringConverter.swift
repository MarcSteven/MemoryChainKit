//
//  StringConverter.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/24.
//  Copyright © 2020 Marc Steven(.com/MarcSteven). All rights reserved.
//

import Foundation
/** string converter */
public struct StringConverter {
    private let string: String

    public init<T: LosslessStringConvertible>(_ value: T) {
        self.string = value.description
    }

    public init?(_ value: Any) {
        if let value = value as? LosslessStringConvertible {
            self.string = value.description
            return
        }

        // Captures NSString
        if let value = value as? String {
            self.string = value
            return
        }

        if let value = value as? NSNumber {
            self.string = value.stringValue
            return
        }

        return nil
    }

    private var url: URL? {
        guard let url = URL(string: string) else {
            return nil
        }

        return url
    }

    private var json: Any? {
        guard !string.isBlank else {
            return nil
        }
        return JSONUtil.parse(jsonString: string)
    }

    private var nsNumber: NSNumber? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.number(from: string)
        
    }
}

public extension StringConverter {
     func get<T>() -> T? {
        switch T.self {
            case is String.Type, is Optional<String>.Type:
                return string as? T
            case is Bool.Type, is Optional<Bool>.Type:
                return Bool(string) as? T
            case is Double.Type, is Optional<Double>.Type:
                return Double(string) as? T
            case is Float.Type, is Optional<Float>.Type:
                return Float(string) as? T
            case is Int.Type, is Optional<Int>.Type:
                return Int(string) as? T
            case is URL.Type, is Optional<URL>.Type:
                return url as? T
            case is NSNumber.Type, is Optional<NSNumber>.Type:
                return nsNumber as? T
            case is NSString.Type, is Optional<NSString>.Type:
                return string as? T
            default:
                return json as? T
        }
    }

     func get<T>() -> T? where T: RawRepresentable, T.RawValue == String {
        T(rawValue: string)
    }
}
