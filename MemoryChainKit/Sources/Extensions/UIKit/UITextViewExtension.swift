//
//  UITextViewExtension.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2020/3/12.
//  Copyright © 2020 Marc Zhao(https://github.com/MarcSteven). All rights reserved.
//

import UIKit
public extension UITextView {
    var mc_hasNonWhitespaceText:Bool {
        return text?.mc_hasNonWhitespaceText ?? false || attributedText?.mc_hasNonWhitespaceText ?? false
    }
    
        /// The maximum number of lines to use for rendering text.
        ///
        /// This property controls the maximum number of lines to use in order to fit
        /// the label’s text into its bounding rectangle. The default value for this
        /// property is `1`. To remove any maximum limit, and use as many lines as
        /// needed, set the value of this property to `0`.
        ///
        /// If you constrain your text using this property, any text that does not fit
        /// within the maximum number of lines and inside the bounding rectangle of the
        /// label is truncated using the appropriate line break mode, as specified by
        /// the `lineBreakMode` property.
        ///
        /// When the label is resized using the `sizeToFit()` method, resizing takes
        /// into account the value stored in this property. For example, if this
        /// property is set to `3`, the `sizeToFit()` method resizes the receiver so
        /// that it is big enough to display three lines of text.
         var numberOfLines: Int {
            get {
                guard let font = font else {
                    return 0
                }

                return Int(contentSize.height / font.lineHeight)
            }
            set { textContainer.maximumNumberOfLines = newValue }
        }
    }

public extension UITextView {
    func ms_point(from touch: UITouch?) -> CGPoint {
        var point = touch?.location(in: self)
        point?.x -= textContainerInset.left
        point?.y -= textContainerInset.top
        return point ?? CGPoint.zero
    }
}
