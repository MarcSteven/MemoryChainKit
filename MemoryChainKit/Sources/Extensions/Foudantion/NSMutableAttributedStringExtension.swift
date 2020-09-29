//
//  NSMutableAttributedStringExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/9/29.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation


public extension NSMutableAttributedString {
    func setAsLink(textToFind:String,
                   linkURL:String) ->Bool {
        let foundedRange = self.mutableString.range(of: textToFind)
        if foundedRange.location != NSNotFound {
            self.addAttribute(.link, value: linkURL, range: foundedRange)
            return true
        }
        return false
    }
}
