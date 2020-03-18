//
//  String+Extension.swift
//  MemoryChain
//
//  Created by Marc Zhao on 2018/8/9.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation
import UIKit

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
