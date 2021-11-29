//
//  Data+Helpers.swift
//  MemoryChain
//
//  Created by Marc Zhao on 2018/8/4.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation

public extension Data {
    var rawBytes: [UInt8] {
        let count = self.count / MemoryLayout<UInt8>.size
        var bytesArray = [UInt8](repeating: 0, count: count)
        (self as NSData).getBytes(&bytesArray, length:count * MemoryLayout<UInt8>.size)
        return bytesArray
    }
    //MARK: - init method to define here 
    init(bytes: [UInt8]) {
        self.init(bytes: UnsafePointer<UInt8>(bytes), count: bytes.count)
    }
    
    mutating func append(_ bytes: [UInt8]) {
        self.append(UnsafePointer<UInt8>(bytes), count: bytes.count)
    }
}

public extension Data {
    func hexEncodedString() ->String {
        return map {String(format: "%02hhx",$0)}.joined()
    }
}

public extension Data {
    /// A convenience method to append string to `Data` using specified encoding.
    ///
    /// - Parameters:
    ///   - string: The string to be added to the `Data`.
    ///   - encoding: The encoding to use for representing the specified string.
    ///               The default value is `.utf8`.
    ///   - allowLossyConversion: A boolean value to determine lossy conversion.
    ///                           The default value is `false`.
 mutating func append(_ string: String, encoding: String.Encoding = .utf8, allowLossyConversion: Bool = false) {
        guard let newData = string.data(using: encoding, allowLossyConversion: allowLossyConversion) else { return }
        append(newData)
    }
}

public extension Data {

    var string: String? {
        return String(data: self, encoding: .utf8)
    }

    var jsonString: String? {
        guard let json = json, JSONSerialization.isValidJSONObject(json) else {
            print("Invalid JSON")
            return nil
        }
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            return data.string
        } catch {
            print(error)
        }

        return nil
    }

    var json: [String:Any]? {
        do {
            let json = try JSONSerialization.jsonObject(with: self, options: []) as? [String:Any]
            return json
        } catch {
            print(error)
        }

        return nil
    }
}
