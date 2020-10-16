//
//  Dictionary+Helpers.swift
//  MemoryChain
//
//  Created by Marc Zhao on 2018/8/6.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation


//MARK: - method

extension Dictionary  where Key == String ,Value == Any?{
    
    /// Convert [String:Any?] to [String:Any]
    ///
    /// - Returns: Dictionary
    func filterNil() ->Dictionary<String,Any> {
        var dic :[String:Any] = .init(minimumCapacity:self.count)
        for arg in self {
            guard let value = arg.value else {
                continue
            }
            dic[arg.key] = value
        }
        return dic
    }
    
}
//MARK: - URLEncode
public extension Dictionary {
    func urlEncodedQueryString(using encoding: String.Encoding) -> String {
        var parts = [String]()
        for (key, value) in self {
            let keyString = "\(key)".urlEncodedString()
            let valueString = "\(value)".urlEncodedString(keyString == "status")
            let query: String = "\(keyString)=\(valueString)"
            parts.append(query)
        }
        return parts.joined(separator: "&")
    }
}

public extension Dictionary {
    subscript<Result>(key:Key,as type:Result.Type) ->Result? {
        get {
            return self[key] as? Result
        }
        set {
            guard let value = newValue as? Value else {
                return
            }
            self[key] = value
        }
        
    }
}
public extension Dictionary where Key: ExpressibleByStringLiteral, Value: Any {
    var jsonString: String? {
        if let dict = (self as AnyObject) as? [String: AnyObject] {
            do {
                let data = try JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions(rawValue: 0))
                if let string = String(data: data, encoding: String.Encoding.utf8) {
                    return string
                }
            } catch {
                print(error)
            }
        }
        return nil
    }
}

public extension Dictionary where Key == String {

    var jsonString: String? {
        guard let data = data else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }

    var data: Data? {

        guard JSONSerialization.isValidJSONObject(self) else {
            print("Invalid JSON")
            return nil
        }

        do {
            let data = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return data
        } catch {
            print(error)
        }

        return nil
    }
}

