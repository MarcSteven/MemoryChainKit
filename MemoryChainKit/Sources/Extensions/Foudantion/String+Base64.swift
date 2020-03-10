//
//  String+Base64.swift
//  MemoryChain
//
//  Created by Marc Zhao on 2018/8/9.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation

public extension String {
    func toBase64() ->String {
        return  Data(self.utf8).base64EncodedString()
    }
    //MARK: - decode a string from base64,return nil if unsucessfully
    func fromBase64() ->String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
}
