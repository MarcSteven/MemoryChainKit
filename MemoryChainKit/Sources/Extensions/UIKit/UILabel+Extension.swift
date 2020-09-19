//
//  UILabel+Extension.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/2/16.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//
import UIKit
extension UILabel {
    public static func build(block:((UILabel)->Void)) ->UILabel {
        let label = UILabel(frame: .zero)
        block(label)
        return label
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
  
  func configureHeaderLabel(withText text: String) {
    configure(withText: text, size: .headerTextSize, alignment: .left, lines: 0, weight: .bold)
  }
  
  func configureSubHeaderLabel(withText text: String) {
    configure(withText: text, size: .subHeaderTextSize, alignment: .left, lines: 0, weight: .semibold)
  }
  
  func configureHeroLabel(withText text: String) {
    configure(withText: text, size: .heroTextSize, alignment: .left, lines: 0, weight: .heavy)
  }
  
  func configureAppHeaderLabel(withText text: String){
    configure(withText: text, size: .appHeaderTextSize, alignment: .left, lines: 2, weight: .medium)
  }
  
  func configureAppSubHeaderLabel(withText text: String) {
    configure(withText: text, size: .appSubHeaderTextSize, alignment: .left, lines: 2, weight: .regular)
  }
  
  func configureTinyLabel(withText text: String) {
    configure(withText: text, size: .tinyTextSize, alignment: .center, lines: 1, weight: .regular)
  }
  
  private func configure(withText newText: String,
                         size: CGFloat,
                         alignment: NSTextAlignment,
                         lines: Int,
                         weight: UIFont.Weight) {
    text = newText
    font = UIFont.systemFont(ofSize: size, weight: weight)
    textAlignment = alignment
    numberOfLines = lines
    lineBreakMode = .byTruncatingTail
  }
}
