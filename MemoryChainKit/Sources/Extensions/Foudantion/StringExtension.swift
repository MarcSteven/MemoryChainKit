//
//  String+Extension.swift
//  MemoryChain
//
//  Created by Marc Zhao on 2018/8/9.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation
import UIKit
//MARK: - is Valid email
extension String {
  public  func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}
extension String {
   /// extract substrings from a string that match a regex pattern.
   
       func regex (pattern: String) -> [String] {
         do {
            let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options(rawValue: 0))
           let nsstr = self as NSString
           let all = NSRange(location: 0, length: nsstr.length)
           var matches : [String] = [String]()
            regex.enumerateMatches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: all) {
             (result : NSTextCheckingResult?, _, _) in
             if let r = result {
                let result = nsstr.substring(with: r.range) as String
               matches.append(result)
             }
           }
           return matches
         } catch {
           return [String]()
         }
       }

      public func isMatch(_ pattern: String) -> Bool {
        return  !regex(pattern: pattern).isEmpty
     
}
}

extension StringProtocol {
    public func index(from: Int) -> Index? {
        guard
            from > -1,
            let index = self.index(startIndex, offsetBy: from, limitedBy: endIndex)
        else {
            return nil
        }

        return index
    }

    /// Returns the element at the specified `index` iff it is within bounds,
    /// otherwise `nil`.
    public func at(_ index: Int) -> String? {
        guard let index = self.index(from: index), let character = at(index) else {
            return nil
        }

        return String(character)
    }
}

// MARK: - `at(:)`

extension String {
    /// Returns the `Substring` at the specified range iff it is within bounds, otherwise `nil`.
    ///
    /// e.g., `"Hello world"[..<5] // → "Hello"`
    public func at(_ range: PartialRangeUpTo<Int>) -> Substring? {
        hasIndex(range) ? self[range] : nil
    }

    /// Returns the `Substring` at the specified range iff it is within bounds, otherwise `nil`.
    ///
    /// e.g., `"Hello world"[...4] // → "Hello"`
    public func at(_ range: PartialRangeThrough<Int>) -> Substring? {
        hasIndex(range) ? self[range] : nil
    }

    /// Returns the `Substring` at the specified range iff it is within bounds, otherwise `nil`.
    ///
    /// e.g., `"Hello world"[0...] // → "Hello world"`
    public func at(_ range: PartialRangeFrom<Int>) -> Substring? {
        hasIndex(range) ? self[range] : nil
    }

    /// Returns the `Substring` at the specified range iff it is within bounds, otherwise `nil`.
    ///
    /// e.g., `"Hello world"[0..<5] // → "Hello"`
    public func at(_ range: CountableRange<Int>) -> Substring? {
        hasIndex(range) ? self[range] : nil
    }

    /// Returns the `Substring` at the specified range iff it is within bounds, otherwise `nil`.
    ///
    /// e.g., `"Hello world"[0...4] // → "Hello"`
    public func at(range: CountableClosedRange<Int>) -> Substring? {
        hasIndex(range) ? self[range] : nil
    }
}

// MARK: - Ranges

extension String {
    /// e.g., `"Hello world"[..<5] // → "Hello"`
    private subscript(range: PartialRangeUpTo<Int>) -> Substring {
        self[..<index(startIndex, offsetBy: range.upperBound)]
    }

    /// e.g., `"Hello world"[...4] // → "Hello"`
    private subscript(range: PartialRangeThrough<Int>) -> Substring {
        self[...index(startIndex, offsetBy: range.upperBound)]
    }

    /// e.g., `"Hello world"[0...] // → "Hello world"`
    private subscript(range: PartialRangeFrom<Int>) -> Substring {
        self[index(startIndex, offsetBy: range.lowerBound)...]
    }

    /// e.g., `"Hello world"[0..<5] // → "Hello"`
    private subscript(range: CountableRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(startIndex, offsetBy: range.upperBound)
        return self[start..<end]
    }

    /// e.g., `"Hello world"[0...4] // → "Hello"`
    private subscript(range: CountableClosedRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(startIndex, offsetBy: range.upperBound)
        return self[start...end]
    }
}



// MARK: - `hasIndex(:)`

extension String {
    /// Return true iff range is in `self`.
    private func hasIndex(_ range: PartialRangeUpTo<Int>) -> Bool {
        range.upperBound >= firstIndex && range.upperBound < lastIndex
    }

    /// Return true iff range is in `self`.
    private func hasIndex(_ range: PartialRangeThrough<Int>) -> Bool {
        range.upperBound >= firstIndex && range.upperBound < lastIndex
    }

    /// Return true iff range is in `self`.
    private func hasIndex(_ range: PartialRangeFrom<Int>) -> Bool {
        range.lowerBound >= firstIndex && range.lowerBound < lastIndex
    }

    /// Return true iff range is in `self`.
    private func hasIndex(_ range: CountableRange<Int>) -> Bool {
        range.lowerBound >= firstIndex && range.upperBound < lastIndex
    }

    /// Return true iff range is in `self`.
    private func hasIndex(_ range: CountableClosedRange<Int>) -> Bool {
        range.lowerBound >= firstIndex && range.upperBound < lastIndex
    }
}

extension String {
    private var firstIndex: Int {
        startIndex.utf16Offset(in: self)
    }

    private var lastIndex: Int {
        endIndex.utf16Offset(in: self)
    }
}

extension String {
    private var nsString:NSString {
        return self as NSString
    }
    public var lastPathComponent:String {
        return nsString.lastPathComponent
    }
    public var deletingLastPathComponent:String {
        return nsString.deletingLastPathComponent
    }
    
    public var deletingPathExtension:String {
        return nsString.deletingPathExtension
    }
}

public extension String {
    func replacingOccurrences(of search:String, with replacement:String,count maxReplacement :Int) ->String {
        var count = 0
        var returnValue = self
        while let range = returnValue.range(of: search) {
            returnValue = returnValue.replacingCharacters(in: range, with: replacement)
            count += 1
            if count  == maxReplacement {
                return  returnValue
            }
        }
        return returnValue
    }
    func isPhoneNumber()->Bool {
        let mobile = "^1((3[0-9]|4[57]|5[0-35-9]|7[0678]|8[0-9])\\d{8}$)"
        
        let CM = "(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)"
        
        let CU = "(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)"
        
        let CT = "(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)"
        
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        
        let regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
        
        let regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
        
        let regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
        
        if ((regextestmobile.evaluate(with: self) == true)
            || (regextestcm.evaluate(with: self)  == true)
            || (regextestct.evaluate(with: self)  == true)
            || (regextestcu.evaluate(with: self)  == true)) {
            return true
        } else {
            return false
        }
    }
}

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
public extension String {
    var localized:String {
           
           return NSLocalizedString(self,comment:"")
       }
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
    
    var isBlank:Bool {
        return allSatisfy({$0.isWhitespace})
    }
    // 获取字符串的行数
    var lines: [String] {
        return self.components(separatedBy: NSCharacterSet.newlines)
    }
    
    var hex: String {
        let data = self.data(using: .utf8)!
        return data.map { String(format: "%02x", $0) }.joined()
    }
    
    
    var isHexEncoded: Bool {
        guard starts(with: "0x") else {
            return false
        }
        let regex = try! NSRegularExpression(pattern: "^0x[0-9A-Fa-f]*$")
        if regex.matches(in: self, range: NSRange(self.startIndex..., in: self)).isEmpty {
            return false
        }
        return true
    }
    
    var doubleValue: Double {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.decimalSeparator = "."
        if let result = formatter.number(from: self) {
            return result.doubleValue
        } else {
            formatter.decimalSeparator = ","
            if let result = formatter.number(from: self) {
                return result.doubleValue
            }
        }
        return 0
    }
    
    var trimmed: String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    var asDictionary: [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
                return [:]
            }
        }
        return [:]
    }
    
    var drop0x: String {
        if self.count > 2 && self.substring(with: 0..<2) == "0x" {
            return String(self.dropFirst(2))
        }
        return self
    }
    
    var add0x: String {
        return "0x" + self
    }
}

extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }
    func range(_ start:Int,
               _ count:Int) ->Range<String.Index> {
        let i = self.index( start >= 0 ? self.startIndex : self.endIndex,offsetBy:start)
        let j = self.index(i, offsetBy: count)
        return i..<j
        
    }
    func nsRange(_ start:Int ,_ count:Int) ->NSRange {
        return NSRange(self.range(start, count),in:self)
    }
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
}
//MARK: - subscript for the String
public extension String {
    subscript(i:Int) ->String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}

public extension String {
    var fileExtension:String? {
        guard let period = firstIndex(of:".") else {
            return nil
        }
        let extensionStart = index(after: period)
        return String(self[extensionStart...])
    }
}

extension String {
    
    public   var queryStringParameters: Dictionary<String, String> {
        var parameters = Dictionary<String, String>()
        let scanner = Scanner(string: self)
        var key: NSString?
        var value: NSString?
        while !scanner.isAtEnd {
            key = nil
            scanner.scanUpTo("=", into: &key)
            scanner.scanString("=", into: nil)
            value = nil
            scanner.scanUpTo("&", into: &value)
            scanner.scanString("&", into: nil)
            if let key = key as String?, let value = value as String? {
                parameters.updateValue(value, forKey: key)
            }
        }
        return parameters
    }
    
    public func urlEncodedString(_ encodeAll: Bool = false) -> String {
        var allowedCharacterSet: CharacterSet = .urlQueryAllowed
        allowedCharacterSet.remove(charactersIn: "\n:#/?@!$&'()*+,;=")
        if !encodeAll {
            allowedCharacterSet.insert(charactersIn: "[]")
        }
        return self.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet)!
    }
}

extension String {
    func matchStrRange(_ matchStr: String) -> [NSRange] {
        var selfStr = self as NSString
        var withStr = Array(repeating: "X", count: (matchStr as NSString).length).joined(separator: "") //辅助字符串
        if matchStr == withStr { withStr = withStr.lowercased() } //临时处理辅助字符串差错
        var allRange = [NSRange]()
        while selfStr.range(of: matchStr).location != NSNotFound {
            let range = selfStr.range(of: matchStr)
            allRange.append(NSRange(location: range.location,length: range.length))
            selfStr = selfStr.replacingCharacters(in: NSMakeRange(range.location, range.length), with: withStr) as NSString
        }
        return allRange
    }
    
    // 设置不同字体颜色
    func setAttributeColor(_ color: UIColor, _ string: String) ->NSMutableAttributedString {
        if (self.isEmpty || !self.contains(self)) {
            return NSMutableAttributedString(string: "")
        }
        let attrstring: NSMutableAttributedString = NSMutableAttributedString(string: self)
        let str = NSString(string: self)
        let theRange = str.range(of: string)
        // 颜色处理
        attrstring.addAttribute(NSAttributedString.Key.foregroundColor, value:color, range: theRange)
        return attrstring
    }
}


extension String {
   public  mutating func removeFirstLetterIfDash() {
        let initialCharacter = String(self[..<index(after: startIndex)])
        if initialCharacter == "/" {
            if count > 1 {
                remove(at: startIndex)
            }else {
                self = ""
            }
        }
    }
   public  mutating func removeLastLetterIfDash() {
        let initialCharacter:String
        if count > 1 {
                initialCharacter = String(self[index(endIndex, offsetBy: -1)...])
            } else {
                initialCharacter = String(self[..<endIndex])
            }

            if initialCharacter == "/" {
                if count > 1 {
                    remove(at: index(endIndex, offsetBy: -1))
                } else {
                    self = ""
                }
            }
        }
}
//MARK- encode

extension String {
  public   func encodeUTF8() -> String? {
               if let _ = URL(string: self) {
                   return self
               }

               var components = self.components(separatedBy: "/")
               guard let lastComponent = components.popLast(),
                   let endcodedLastComponent = lastComponent.addingPercentEncoding(withAllowedCharacters: .urlQueryParametersAllowed) else {
                   return nil
               }

               return (components + [endcodedLastComponent]).joined(separator: "/")
           }

}
