//
//  String+hasText.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2020/3/12.
//  Copyright © 2020 Marc Zhao(https://github.com/MarcSteven). All rights reserved.
//

import Foundation

public extension String {
    var mc_hasText:Bool {
        return !isEmpty
    }
    var mc_hasNonWhitespaceText:Bool {
        return mc_hasText && !self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
