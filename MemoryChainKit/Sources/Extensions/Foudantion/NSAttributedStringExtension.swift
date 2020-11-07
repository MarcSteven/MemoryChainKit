//
//  NSAttributedStringExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/16.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import UIKit

// MARK: - NSAttributedString Extension

@objc public extension NSAttributedString {
     

 
     func setLineSpacing(_ spacing: CGFloat) -> NSMutableAttributedString {
         NSMutableAttributedString(attributedString: self).setLineSpacing(spacing)
    }

    var attributesDescription: String {
        let text = string as NSString
        let range = NSRange(location: 0, length: length)
        var result: [String] = []

        enumerateAttributes(in: range) { attributes, range, _ in
            result.append("\nstring: \(text.substring(with: range))")
            result.append("range: \(NSStringFromRange(range))")
            attributes.forEach {
                var value = $0.value

                if $0.key == .foregroundColor, let color = value as? UIColor {
                    value = color.hexString
                }

                result.append("\($0.key.rawValue): \(value)")
            }
        }

        return result.joined(separator: "\n")
    }
}

// MARK: - NSMutableAttributedString Extension

extension NSMutableAttributedString {
    public override func setLineSpacing(_ spacing: CGFloat) -> Self {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        addAttributes([.paragraphStyle: paragraphStyle], range: NSRange(location: 0, length: string.count))
        return self
    }

    open func replaceAttribute(_ name: Key, value: Any, range: NSRange) {
        removeAttribute(name, range: range)
        addAttribute(name, value: value, range: range)
    }
}

extension NSMutableAttributedString {
    open func underline(_ text: String, style: NSUnderlineStyle = .single) -> Self {
        addAttribute(.underlineStyle, value: style.rawValue, range: range(of: text))
        return self
    }

    open func foregroundColor(_ color: UIColor, for text: String? = nil) -> Self {
        addAttribute(.foregroundColor, value: color, range: range(of: text))
        return self
    }

    open func backgroundColor(_ color: UIColor, for text: String? = nil) -> Self {
        addAttribute(.backgroundColor, value: color, range: range(of: text))
        return self
    }

    open func font(_ font: UIFont, for text: String? = nil) -> Self {
        addAttribute(.font, value: font, range: range(of: text))
        return self
    }

    open func textAlignment(_ textAlignment: NSTextAlignment, for text: String? = nil) -> Self {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = textAlignment
        addAttribute(.paragraphStyle, value: paragraphStyle, range: range(of: text))
        return self
    }

    open func link(url: URL?, text: String) -> Self {
        guard let url = url else {
            return self
        }

        addAttribute(.link, value: url, range: range(of: text))
        return self
    }

    private func range(of text: String?) -> NSRange {
        let range: NSRange

        if let text = text {
            range = (string as NSString).range(of: text)
        } else {
            range = NSRange(location: 0, length: string.count)
        }

        return range
    }
}

extension NSAttributedString {
    /// Returns an `NSAttributedString` object initialized with a given `string` and `attributes`.
    ///
    /// Returns an `NSAttributedString` object initialized with the characters of `aString`
    /// and the attributes of `attributes`. The returned object might be different from the original receiver.
    ///
    /// - Parameters:
    ///   - string: The string for the new attributed string.
    ///   - image: The image for the new attributed string.
    ///   - baselineOffset: The value indicating the `image` offset from the baseline. The default value is `0`.
    ///   - attributes: The attributes for the new attributed string. For a list of attributes that you can include in this
    ///                 dictionary, see `Character Attributes`.
    public convenience init(string: String? = nil, image: UIImage, baselineOffset: CGFloat = 0, attributes: [Key: Any]? = nil) {
        let attachment = NSAttributedString.attachmentAttributes(for: image, baselineOffset: baselineOffset)

        guard let string = string else {
            self.init(string: attachment.string, attributes: attachment.attributes)
            return
        }

        let attachmentAttributedString = NSAttributedString(string: attachment.string, attributes: attachment.attributes)
        let attributedString = NSMutableAttributedString(string: string, attributes: attributes)
        attributedString.append(attachmentAttributedString)
        self.init(attributedString: attributedString)
    }

    private static func attachmentAttributes(for image: UIImage, baselineOffset: CGFloat) -> (string: String, attributes: [Key: Any]) {
        let paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.lineHeightMultiple = 0.9

        let attachment = NSTextAttachment(data: nil, ofType: nil)
        attachment.image = image

        let attachmentCharacterString = String(Character(UnicodeScalar(NSTextAttachment.character)!))

        return (string: attachmentCharacterString, attributes: [
            .attachment: attachment,
            .baselineOffset: baselineOffset,
            .paragraphStyle: paragraphStyle
        ])
    }
}


extension NSAttributedString {
    public enum CaretDirection {
        case none
        case up
        case down
        case back
        case forward


        var imageBaselineOffset: CGFloat {
            switch self {
                case .none:
                    return 0
                case .up, .down:
                    return 2
                case .back, .forward:
                    return 0
            }
        }
    }
}

// MARK: - Bullets

extension NSAttributedString {
    public enum BulletStyle {
        case `default`
        case ordinal

        fileprivate func bullet(at index: Int) -> String {
            switch self {
                case .default:
                    return "•   "
                case .ordinal:
                    return (index + 1).description + ".  "
            }
        }
    }

}
public extension NSAttributedString {
    var mc_hasText:Bool {
        return string.mc_hasText
    }
    var mc_hasNonWhitespaceText:Bool {
        return string.mc_hasNonWhitespaceText
    }
}
public extension NSAttributedString {
  
  enum Attribute {
    case attachment(NSTextAttachment)
    case backgroundColor(UIColor)
    case baselineOffset(NSNumber)
    case font(UIFont)
    case foregroundColor(UIColor)
    case kern(NSNumber)
    case ligature(NSNumber)
    case link(String)
    case linkUrl(URL)
    case paragraphStyle(NSParagraphStyle)
    case shadow(NSShadow)
    case underlineColor(UIColor)
    case underlineStyle(NSUnderlineStyle)
  }

  // Define the equivalent kv here.
  fileprivate static func kvFor(_ attributeKey: Attribute) -> (Key, Any) {
    switch attributeKey {
    case .attachment(let value):
      return (.attachment, value)
    case .backgroundColor(let value):
      return (.backgroundColor, value)
    case .font(let value):
      return (.font, value)
    case .foregroundColor(let value):
      return (.foregroundColor, value)
    case .baselineOffset(let value):
      return (.baselineOffset, value)
    case .kern(let value):
      return (.kern, value)
    case .ligature(let value):
      return (.ligature, value)
    case .link(let value):
      return (.link, value)
    case .linkUrl(let value):
      return (.link, value)
    case .paragraphStyle(let value):
      return (.paragraphStyle, value)
    case .shadow(let value):
      return (.shadow, value)
    case .underlineColor(let value):
      return (.underlineColor, value)
    case .underlineStyle(let value):
      return (.underlineStyle, value.rawValue)
    }
  }
  
  enum Scope {
    case all
    case subtext(String)
    case closedRange(ClosedRange<Int>)
  }
  
  convenience init(string:String, attrs:[Attribute] = []) {
    self.init(string: string, attributes: attrs.dictionaryValue)
  }
}

public extension NSMutableAttributedString {
  
  func addAttributes(attrs:[Attribute], for scope:Scope) {
    switch scope {
    case .all:
      addAttributes(attrs.dictionaryValue, range:NSRange(location: 0, length: length))
    case .subtext(let substr):
      let range = (string as NSString).range(of: substr)
      addAttributes(attrs.dictionaryValue, range:range)
    case .closedRange(let value):
      if let first = value.first, let last = value.last {
        let nsRange = NSRange(location: first, length: last - first + 1)
        addAttributes(attrs.dictionaryValue, range:nsRange)
      }
    }
  }
}

fileprivate extension Sequence where Element == NSAttributedString.Attribute {
  var dictionaryValue:[NSAttributedString.Key: Any] {
    return reduce([:]) { (result, attr) -> [NSAttributedString.Key: Any] in
      var result = result
      let kv = NSAttributedString.kvFor(attr)
      result[kv.0] = kv.1
      return result
    }
  }
}
