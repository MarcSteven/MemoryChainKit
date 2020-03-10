//
//  String+Prefix.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/11/9.
//  Copyright © 2019 Memory Chain network technology(China) co,LTD. All rights reserved.
//

import Foundation

public extension String {
    func removingPrefix(_ prefix:String) ->String {
        guard hasPrefix(prefix) else {
            return self
            
        }
        return String(dropFirst(prefix.count))
    }
    func removingSuffix(_ suffix:String) ->String {
        guard hasPrefix(suffix) else {
            return self
        }
        return String(dropLast(suffix.count))
    }
    func appendingSuffixIfNeeded(_ suffix:String) ->String {
        guard !hasSuffix(suffix) else {
            return self
        }
        return appending(suffix)
    }
}
