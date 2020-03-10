//
//  Bundle+DecodeJSON.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/1/11.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation

public extension Bundle {
    func decode<T:Decodable>( _ type:T.Type,from fileName:String) ->T {
        guard let json = url(forResource: fileName, withExtension: nil) else {
            fatalError("Failed to locate \(fileName) in app bundle")
        }
        guard let jsonData = try? Data(contentsOf: json) else {
            fatalError("failed to locate \(fileName) in app bundle")
        }
        let decoder = JSONDecoder()
        guard let result = try? decoder.decode(T.self, from: jsonData) else {
            fatalError("failed to locate \(fileName) in app bundle")
        }
        return result
    }
}
