//
//  Data+Hex.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/10/8.
//  Copyright © 2019 Memory Chain network technology(China) co,LTD. All rights reserved.
//

import Foundation


public extension Data {
    func hexEncodedString() ->String {
        return map {String(format: "%02hhx",$0)}.joined()
    }
}
