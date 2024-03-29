//
//  String+Extension.swift
//  MemoryChain
//
//  Created by Marc Zhao on 2018/8/9.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import CommonCrypto
//MARK: - is Valid email
 public extension String {
  var asCoordinates: CLLocationCoordinate2D? {
        let components = self.components(separatedBy: ",")
        if components.count != 2 { return nil }
        let strLat = components[0].trimmed
        let strLng = components[1].trimmed
        if let dLat = Double(strLat),
            let dLng = Double(strLng) {
            return CLLocationCoordinate2D(latitude: dLat, longitude: dLng)
        }
        return nil
    }
  var isAlphanumeric: Bool {
        !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
  var containsOnlyDigits: Bool {
        let notDigits = NSCharacterSet.decimalDigits.inverted
        return rangeOfCharacter(from: notDigits, options: String.CompareOptions.literal, range: nil) == nil
    }
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}
public extension String {
  func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)

        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)

        return ceil(boundingBox.width)
    }
}
@objc public extension NSAttributedString {
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)

        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)

        return ceil(boundingBox.width)
    }
}
public extension String {
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

    func isMatch(_ pattern: String) -> Bool {
        return  !regex(pattern: pattern).isEmpty
     
}
}

public extension StringProtocol {
     func index(from: Int) -> Index? {
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
     func at(_ index: Int) -> String? {
        guard let index = self.index(from: index), let character = at(index) else {
            return nil
        }

        return String(character)
    }
}

// MARK: - `at(:)`

public extension String {
    /// Returns the `Substring` at the specified range iff it is within bounds, otherwise `nil`.
    ///
    /// e.g., `"Hello world"[..<5] // → "Hello"`
     func at(_ range: PartialRangeUpTo<Int>) -> Substring? {
        hasIndex(range) ? self[range] : nil
    }

    /// Returns the `Substring` at the specified range iff it is within bounds, otherwise `nil`.
    ///
    /// e.g., `"Hello world"[...4] // → "Hello"`
     func at(_ range: PartialRangeThrough<Int>) -> Substring? {
        hasIndex(range) ? self[range] : nil
    }

    /// Returns the `Substring` at the specified range iff it is within bounds, otherwise `nil`.
    ///
    /// e.g., `"Hello world"[0...] // → "Hello world"`
     func at(_ range: PartialRangeFrom<Int>) -> Substring? {
        hasIndex(range) ? self[range] : nil
    }

    /// Returns the `Substring` at the specified range iff it is within bounds, otherwise `nil`.
    ///
    /// e.g., `"Hello world"[0..<5] // → "Hello"`
     func at(_ range: CountableRange<Int>) -> Substring? {
        hasIndex(range) ? self[range] : nil
    }

    /// Returns the `Substring` at the specified range iff it is within bounds, otherwise `nil`.
    ///
    /// e.g., `"Hello world"[0...4] // → "Hello"`
     func at(range: CountableClosedRange<Int>) -> Substring? {
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
    var asArray: [Any]? {
        guard let data = self.data(using: .utf8) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [Any]
    }
    var asDict: [String: Any]? {
        guard let data = self.data(using: .utf8) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
    }
    var asAttributedString: NSAttributedString? {
        guard let data = self.data(using: .utf8) else { return nil }
        return try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
    }
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

public extension String {
    
    var queryStringParameters: Dictionary<String, String> {
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
    
    func urlEncodedString(_ encodeAll: Bool = false) -> String {
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


public extension String {
     mutating func removeFirstLetterIfDash() {
        let initialCharacter = String(self[..<index(after: startIndex)])
        if initialCharacter == "/" {
            if count > 1 {
                remove(at: startIndex)
            }else {
                self = ""
            }
        }
    }
     mutating func removeLastLetterIfDash() {
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

public extension String {
     func encodeUTF8() -> String? {
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

// MARK: - Convenience Extension

public extension String {
    /// Returns a boolean value indicating whether the `self` matches the conditions
    /// specified by the `rule`.
    ///
    /// ```swift
    /// "help@example.com".validate(rule: .email) // valid
    /// "help.example.com".validate(rule: .email) // invalid
    /// ```
    ///
    /// - Parameter rule: The rule against which to evaluate `self`.
    /// - Returns: `true` if `self` matches the conditions specified by the given
    ///            `rule`, otherwise `false`.
     func validate(rule: ValidationRule<String>) -> Bool {
        rule.validate(self)
    }
}
public extension String {
  var uppercasedFirstLetter: String {
    guard !self.isEmpty else { return self }
    return prefix(1).uppercased() + dropFirst()
  }
}
// see here  https://stackoverflow.com/questions/31780453/how-to-get-the-filename-from-the-filepath-in-swift/35033432
public extension String {
    var fileURL: URL {
        return URL(fileURLWithPath: self)
    }
    var pathExtension: String {
        return fileURL.pathExtension
    }
    var lastPathComponent: String {
        return fileURL.lastPathComponent
    }
}
public extension String {
    
    func appending(_ params: [String: String]) -> String {
        return appending(self, params)
    }
    
    func appending(_ url: String, _ params: [String: String]) -> String {
        guard var components = URLComponents(string: url) else {
            return url
        }
        
        let query = components.percentEncodedQuery ?? ""
        let temp = params.compactMap({
            guard !$0.isEmpty, !$1.isEmpty else { return nil }
            guard let _ = Foundation.URL(string: $1) else {
                let encoded = $1.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? $1
                return "\($0)=\(encoded)"
            }
            
            let string = "?!@#$^&%*+,:;='\"`<>()[]{}/\\| "
            let character = CharacterSet(charactersIn: string).inverted
            let encoded = $1.addingPercentEncoding(withAllowedCharacters: character) ?? $1
            return "\($0)=\(encoded)"
        }).joined(separator: "&")
        components.percentEncodedQuery = query.isEmpty ? temp : query + "&" + temp
        return components.url?.absoluteString ?? url
    }
}

public extension String {
    func convertEmojiToImage() ->UIImage? {
        let size = CGSize(width: 30, height: 35)
                UIGraphicsBeginImageContextWithOptions(size, false, 0)
                UIColor.clear.set()
                let rect = CGRect(origin: CGPoint(), size: size)
                UIRectFill(CGRect(origin: CGPoint(), size: size))
                (self as NSString).draw(in: rect, withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30)])
                let image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                return image
        
    }
}
public extension String {
  var firstLine: String {
        return components(separatedBy: .newlines).first ?? self
    }
}
public extension String {
     func isImage() -> Bool {
        // Add here your image formats.
        let imageFormats = ["jpg", "jpeg", "png", "gif"]

        if let ext = self.getExtension() {
            return imageFormats.contains(ext)           
        }

        return false
    }

     func getExtension() -> String? {
       let ext = (self as NSString).pathExtension

       if ext.isEmpty {
           return nil
       }

       return ext
    }

     func isURL() -> Bool {
       return URL(string: self) != nil
    }

}
public extension String {
    enum Regex: String {
        case codableModelStartLine = ".+\\s*:\\s*.*(Codable|Decodable|Encodable).*\\{"
        case openBracket = "\\{"
        case closeBracket = "\\}"
        case closureOrTuple = "\\(.*\\)"
        case spaceOrTabIndent = "^(\\s|\\t)*"
        case toggleComments = "^\\s*\\/\\/"

        case codablePropertyLine = ".*(let|var)\\s+\\w+\\s*(:|=).+"
        case codablePropertyName = "\\w+(?=\\s*:)"
        case customKey = "\\/\\/\\s*\\w+"
    }
    func match(regex: Regex) -> String?  {
            return self.match(regex: regex.rawValue)
        }
        
        func match(regex: String) -> String? {
            let matchList: [String] = match(regex: regex)
            return matchList.first
        }
        
        func match(regex: String) -> [String] {
            if isEmpty {
                return []
            }
            do {
                let regex = try NSRegularExpression(pattern: regex, options: [])
                let results = regex.matches(in: self, options: [], range: NSRange.init(startIndex..., in: self))
                return results.map({ (result) -> String in
                    let range = Range.init(result.range, in: self)
                    return String(self[range!])
                })
            }
            catch {
                return []
            }
        }
        
        func snakeCased() -> String? {
            let pattern = "([a-z0-9])([A-Z])"
            
            let regex = try? NSRegularExpression(pattern: pattern, options: [])
            let range = NSRange(location: 0, length: count)
            return regex?.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "$1_$2").lowercased()
        }

}



public extension String {
    func size(withFont font: UIFont) -> CGSize {
        let attributes = [NSAttributedString.Key.font: font]
        return (self as NSString).size(withAttributes: attributes)
    }
}


public extension String {
    /// 验证身份证号码
    func isValidIDCard() -> Bool {
        struct Static {
            fileprivate static let predicate: NSPredicate = {
                let regex = "(^\\d{15}$)|(^\\d{17}([0-9]|X)$)"
                let predicate = NSPredicate(format: "SELF MATCHES %@", argumentArray: [regex])
                return predicate
            }()
            fileprivate static let provinceCodes = [
                "11", "12", "13", "14", "15",
                "21", "22", "23",
                "31", "32", "33", "34", "35", "36", "37",
                "41", "42", "43", "44", "45", "46",
                "50", "51", "52", "53", "54",
                "61", "62", "63", "64", "65",
                "71", "81", "82", "91"]
        }
        // 初步验证
        guard Static.predicate.evaluate(with: self) else {
            return false
        }
        // 验证省份代码。如果需要更精确的话，可以把前六位行政区划代码都列举出来比较。
        let provinceCode = String(self.prefix(2))
        guard Static.provinceCodes.contains(provinceCode) else {
            return false
        }
        if self.count == 15 {
            return self.validate15DigitsIDCardNumber()
        } else {
            return self.validate18DigitsIDCardNumber()
        }
    }
    
    /// 15位身份证号码验证。
    // 6位行政区划代码 + 6位出生日期码(yyMMdd) + 3位顺序码
    private func validate15DigitsIDCardNumber() -> Bool {
        let birthdate = "19\(self.substring(from: 6, to: 11)!)"
        return birthdate.validateBirthDate()
    }
    
    /// 18位身份证号码验证。
    // 6位行政区划代码 + 8位出生日期码(yyyyMMdd) + 3位顺序码 + 1位校验码
    private func validate18DigitsIDCardNumber() -> Bool {
        let birthdate = self.substring(from: 6, to: 13)!
        guard birthdate.validateBirthDate() else {
            return false
        }
        struct Static {
            static let weights = [7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2]
            static let validationCodes = ["1", "0", "X", "9", "8", "7", "6", "5", "4", "3", "2"]
        }
        // 验证校验位
        let digits = self.substring(from: 0, to: 16)!.map { Int("\($0)")! }
        var sum = 0
        for i in 0..<Static.weights.count {
            sum += Static.weights[i] * digits[i]
        }
        let mod11 = sum % 11
        let validationCode = Static.validationCodes[mod11]
        return hasSuffix(validationCode)
    }
    
    private func validateBirthDate() -> Bool {
        struct Static {
            static let dateFormatter: DateFormatter = {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyyMMdd"
                return dateFormatter
            }()
        }
        if let _ = Static.dateFormatter.date(from: self) {
            return true
        } else {
            return false
        }
    }
    
    private func substring(from: Int, to: Int) -> String? {
        guard to >= from && from >= 0 && to < count else {
            return nil
        }
        let startIdx = self.index(startIndex, offsetBy: from)
        let endIdx = self.index(startIndex, offsetBy: to)
        return String(self[startIdx...endIdx])
    }
}

// Defines types of hash string outputs available
public enum HashOutputType {
    // standard hex string output
    case hex
    // base 64 encoded string output
    case base64
}

// Defines types of hash algorithms available
public enum HashType {
    case md5
    case sha1
    case sha224
    case sha256
    case sha384
    case sha512

    var length: Int32 {
        switch self {
        case .md5: return CC_MD5_DIGEST_LENGTH
        case .sha1: return CC_SHA1_DIGEST_LENGTH
        case .sha224: return CC_SHA224_DIGEST_LENGTH
        case .sha256: return CC_SHA256_DIGEST_LENGTH
        case .sha384: return CC_SHA384_DIGEST_LENGTH
        case .sha512: return CC_SHA512_DIGEST_LENGTH
        }
    }
}

public extension String {

    /// Hashing algorithm for hashing a string instance.
    ///
    /// - Parameters:
    ///   - type: The type of hash to use.
    ///   - output: The type of output desired, defaults to .hex.
    /// - Returns: The requested hash output or nil if failure.
     func hashed(_ type: HashType, output: HashOutputType = .hex) -> String? {

        // convert string to utf8 encoded data
        guard let message = data(using: .utf8) else { return nil }
        return message.hashed(type, output: output)
    }
    
    ///
    /// Attempts to remove excessive whitespace in text by replacing multiple new lines with just 2.
    /// This first trims whitespace and newlines from the ends
    /// Then normalizes the newlines by replacing {Space}{Newline} with a single newline char
    /// Then finally it looks for any newlines that are 3 or more and replaces them with 2 newlines.
    ///
    /// Example:
    /// ```
    /// This is the first line
    ///
    ///
    ///
    ///
    /// This is the last line
    /// ```
    /// Turns into:
    /// ```
    /// This is the first line
    ///
    /// This is the last line
    /// ```
    ///
    func condenseWhitespace() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            .replacingOccurrences(of: "\\s\n", with: "\n", options: .regularExpression, range: nil)
            .replacingOccurrences(of: "[\n]{3,}", with: "\n\n", options: .regularExpression, range: nil)
    }
}

//MARK: - regex
public extension String {
    
    /// Find all matches of the specified regex.
    ///
    /// - Parameters:
    ///     - regex: the regex to use.
    ///     - options: the regex options.
    ///
    /// - Returns: the requested matches.
    ///
    func matches(regex: String, options: NSRegularExpression.Options = []) -> [NSTextCheckingResult] {
        let regex = try! NSRegularExpression(pattern: regex, options: options)
        let fullRange = NSRange(location: 0, length: count)

        return regex.matches(in: self, options: [], range: fullRange)
    }

    /// Replaces all matches of a given RegEx, with a template String.
    ///
    /// - Parameters:
    ///     - regex: the regex to use.
    ///     - template: the template string to use for the replacement.
    ///     - options: the regex options.
    ///
    /// - Returns: a new string after replacing all matches with the specified template.
    ///
    func replacingMatches(of regex: String, with template: String, options: NSRegularExpression.Options = []) -> String {

        let regex = try! NSRegularExpression(pattern: regex, options: options)
        let fullRange = NSRange(location: 0, length: count)

        return regex.stringByReplacingMatches(in: self,
                                              options: [],
                                              range: fullRange,
                                              withTemplate: template)
    }

    
    /// Returns a NSRange instance starting at position 0, with the entire String's Length
    ///
    var foundationRangeOfEntireString: NSRange {
        return NSRange(location: 0, length: utf16.count)
    }
}
