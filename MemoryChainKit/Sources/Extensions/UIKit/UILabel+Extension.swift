//
//  UILabel+Extension.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/2/16.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//
import UIKit

public extension UILabel {
   
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

