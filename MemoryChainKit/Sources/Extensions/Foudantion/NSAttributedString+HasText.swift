//
//  NSAttributedString+HasText.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2020/3/12.
//  Copyright © 2020 Marc Zhao(https://github.com/MarcSteven). All rights reserved.
//

import Foundation


public extension NSAttributedString {
    var mc_hasText:Bool {
        return string.mc_hasText
    }
    var mc_hasNonWhitespaceText:Bool {
        return string.mc_hasNonWhitespaceText
    }
}
