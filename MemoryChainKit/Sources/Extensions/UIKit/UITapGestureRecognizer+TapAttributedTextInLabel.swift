//
//  UITapGestureRecognizer+TapAttributedTextInLabel.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/5/14.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit
import Foundation

public extension  UITapGestureRecognizer {
    func didTapAttributedTextInLabel(label:UILabel, text: String) ->Bool {
        // Create instances of NSLayoutManager
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: .zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        //configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        //configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        //find the tapped character location and compare it to the specified range
        
        let locationOfTouchInLabel = self.location(in: label)
        
        let textBoundInBox = layoutManager.usedRect(for: textContainer)
        let  textContainerOffset = CGPoint(x: (labelSize.width - textBoundInBox.size.width) * 0.5 - textBoundInBox.origin.x, y: (labelSize.height - textBoundInBox.size.height) * 0.5 - textBoundInBox.origin.y)
        
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        var selfStr = label.text! as NSString
        var withStr = Array(repeating: "X", count: (text as NSString).length).joined(separator: "") //辅助字符串
        if text == withStr { withStr = withStr.lowercased() } //临时处理辅助字符串差错
        var allRange = [NSRange]()
        while selfStr.range(of: text).location != NSNotFound {
            let range = selfStr.range(of: text)
            allRange.append(NSRange(location: range.location,length: range.length))
            selfStr = selfStr.replacingCharacters(in: NSMakeRange(range.location, range.length), with: withStr) as NSString
        }
        return NSLocationInRange(indexOfCharacter, allRange.first!)
    }
}

//Usage:

//***
// if tap .didTapAttributedTextInLabel(label:self.xxxLabel,inRange:range) {


//Substring tapped

//}

//
