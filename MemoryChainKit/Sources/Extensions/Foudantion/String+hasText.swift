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
     var toDigits: String {
            return replacingOccurrences(of: "[^\\d]", with: "", options: .regularExpression, range: startIndex..<endIndex)
        }
        
         subscript (i: Int) -> Character {
            return self[index(startIndex, offsetBy: i)]
        }
        
        
         subscript (range: Range<Int>) -> String {
            let start = index(startIndex, offsetBy: range.lowerBound)
            let end = index(start, offsetBy: (range.upperBound - range.lowerBound))
            return String(self[start..<end])
        }
}
