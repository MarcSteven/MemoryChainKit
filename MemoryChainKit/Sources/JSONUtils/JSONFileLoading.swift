//
//  JSONFileLoading.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2018/12/28.
//  Copyright © 2018 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation




public enum JSONUtilsError:Error {
    case couldNotFindFile
    case fileLoadingFailed
    case fileDeserializationFailed
    case fileNotAJSONDictionary
}
public extension Dictionary where Key:StringProtocol,Value:Any {
    static func from(fileName:String,
                            bundle:Bundle = .main) throws ->JSONDictionary {
        bundle.url(forResource: fileName, withExtension: "json")
        guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
            throw JSONUtilsError.couldNotFindFile
        }
        return try from(url: url)
    }
    
    @discardableResult
    static func from(url:URL) throws ->JSONDictionary {
        guard let jsonData = try? Data(contentsOf: url) else {
            throw JSONUtilsError.fileLoadingFailed
        }
        return try from(jsonData: jsonData)
    }
    static func from(jsonData:Data) throws ->JSONDictionary {
        guard let deserializedJSON = try? JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) else {
            throw JSONUtilsError.fileDeserializationFailed
        }
        guard  let jsonDictionary :JSONDictionary = deserializedJSON as? JSONDictionary else {
            throw JSONUtilsError.fileNotAJSONDictionary
        }
        return jsonDictionary
    }
}
