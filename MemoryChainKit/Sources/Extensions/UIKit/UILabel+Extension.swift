//
//  UILabel+Extension.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/2/16.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//
import UIKit
public extension UILabel {
     static func build(block:((UILabel)->Void)) ->UILabel {
        let label = UILabel(frame: .zero)
        block(label)
        return label
    }
}
//MARK: - set line space 
public extension UILabel {
    func setLineSpace(_ lineSpace: CGFloat, withText text: String?) {
        if text == nil || self == nil {
            return
        }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpace //设置行间距
        paragraphStyle.lineBreakMode = lineBreakMode
        paragraphStyle.alignment = textAlignment

        let attributedString = NSMutableAttributedString(string: text ?? "")
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: text?.count ?? 0))
        attributedText = attributedString
    }

}
public extension UILabel {
    func underLine() {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: textString.count))
            self.attributedText = attributedString
        }
    }
   
    func setAttributeColor(_ color: UIColor, _ string: String) {
        let text = self.text!
        if (text.isEmpty || !text.contains(text)) {
            return
        }
        let attrstring: NSMutableAttributedString = NSMutableAttributedString(string: self.text!)
        let str = NSString(string: text)
        let theRange = str.range(of: string)
        // 颜色处理
        attrstring.addAttribute(NSAttributedString.Key.foregroundColor, value:color, range: theRange)
        self.attributedText = attrstring
    }
    
    func addTapGesture(_ target: Any, _ action: Selector) {
        self.isUserInteractionEnabled = true
        let labelTapGestureRecognizer = UITapGestureRecognizer.init(target: target, action: action)
        self.addGestureRecognizer(labelTapGestureRecognizer)
    }
    
    func insertImage(image: UIImage, index: Int) {
        let markAttribute = NSMutableAttributedString(string:self.text!)
        //以上是富文本显示
        let markattch = NSTextAttachment() //定义一个attachment
        markattch.image = image//初始化图片
        markattch.bounds = CGRect(x: 0, y: 0, width: 9, height: 9) //初始化图片的 bounds
        let markattchStr = NSAttributedString(attachment: markattch) // 将attachment  加入富文本中
        markAttribute.insert(markattchStr, at: index)// 将markattchStr  加入原有文字的某个位置
        self.attributedText = markAttribute
    }
}

public extension UILabel {
    var mc_hasText:Bool {
        guard let text = text else {
            return false
        }
        return text.mc_hasText
    }
    @objc var mc_hasNonWhitespaceText:Bool {
        guard let text = text else {
            return false
        }
        return text.mc_hasNonWhitespaceText
    }
    var mc_hasAttributedText:Bool {
        guard let attributedText = attributedText else {
            return false
        }
        return attributedText.mc_hasText
    }
    var mc_hasNonWhiteSpaceAttributedText:Bool {
        guard let attributedText = attributedText else {
            return false
        }
        return attributedText.mc_hasNonWhitespaceText
    }
    var mc_hasAnyText:Bool {
        return mc_hasText || mc_hasAttributedText
    }
    var mc_hasAnyNonWhitespaceText:Bool {
        return mc_hasNonWhitespaceText || mc_hasNonWhiteSpaceAttributedText
    }
}


public extension UILabel {
  /**
   Turn this option on in IB to have the value of the label cleared on initialization.
   */
  var clearIBValue: Bool {
    set(clear) {
      #if !TARGET_INTERFACE_BUILDER
        if clear {
          self.text = ""
        }
      #endif
    }
    get {
      return false
    }
  }
}

