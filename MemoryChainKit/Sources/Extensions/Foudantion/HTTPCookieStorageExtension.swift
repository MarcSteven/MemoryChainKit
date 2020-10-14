//
//  HTTPCookieStorageExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/10/14.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation



public extension HTTPCookieStorage {
    func deleteCookies() {
        cookies?.forEach {
            deleteCookie($0)
        }
    }
    func setCookies(_ cookies:[HTTPCookie]) {
        cookies.forEach {
            setCookie($0)
        }
    }
}
