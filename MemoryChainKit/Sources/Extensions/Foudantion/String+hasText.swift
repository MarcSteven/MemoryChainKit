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


public extension String {
    /**
    Returns a new string where the first match is replaced with the template.
    You can use template variables like `$` and `$0` in the template. [More info.](https://developer.apple.com/documentation/foundation/nsregularexpression#1965591)
    ```
    import Regex
    "123🦄456".replacingFirstMatch(of: Regex(#"\d+"#), with: "")
    //=> "🦄456"
    ```
    */
//   func replacingFirstMatch(
//        of regex: Regex,
//        with template: String
//    ) -> Self {
//        guard let match = regex.firstMatch(in: self) else {
//            return self
//        }
//
//        let replacement = regex
//            .nsRegex
//            .replacementString(
//                for: match.checkingResult,
//                in: self,
//                offset: 0,
//                template: template
//            )
//
//        return replacingSubrange(match.range, with: replacement)
//    }

    /**
    Returns a new string where the first match is replaced with the template.
    You can use template variables like `$` and `$0` in the template. [More info.](https://developer.apple.com/documentation/foundation/nsregularexpression#1965591)
    ```
    import Regex
    "123🦄456".replacingFirstMatch(of: #"\d+"#, with: "")
    //=> "🦄456"
    ```
    */
//  func replacingFirstMatch(
//        of regexPattern: StaticString,
//        with template: String
//    ) -> Self {
//        replacingFirstMatch(of: Regex(regexPattern), with: template)
//    }

    /**
    Returns a new string where all matches are replaced with the template.
    You can use template variables like `$` and `$0` in the template. [More info.](https://developer.apple.com/documentation/foundation/nsregularexpression#1965591)
    ```
    import Regex
    "123🦄456".replacingAllMatches(of: Regex(#"\d+"#), with: "")
    //=> "🦄"
    ```
    */
//    func replacingAllMatches(
//        of regex: Regex,
//        with template: String,
//        options: Regex.MatchingOptions = []
//    ) -> Self {
//        regex.nsRegex.stringByReplacingMatches(
//            in: self,
//            options: options,
//            range: nsRange,
//            withTemplate: template
//        )
//    }

    /**
    Returns a new string where all matches are replaced with the template.
    You can use template variables like `$` and `$0` in the template. [More info.](https://developer.apple.com/documentation/foundation/nsregularexpression#1965591)
    ```
    import Regex
    "123🦄456".replacingAllMatches(of: #"\d+"#, with: "")
    //=> "🦄"
    ```
    */
//   func replacingAllMatches(
//        of regexPattern: StaticString,
//        with template: String,
//        options: Regex.MatchingOptions = []
//    ) -> Self {
//        replacingAllMatches(of: Regex(coreDataValue: regexPattern as! String.Regex.CoreDataBaseType), with: template, options: options)
//    }
}
