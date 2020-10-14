//
//  HTTPCookieExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/10/14.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation


public extension HTTPCookie {
    var isExpired:Bool {
        guard expiresDate != nil else {
            return false
        }
        if expiresDate! < Date() {
            return true
        }
        return false
    }
}
