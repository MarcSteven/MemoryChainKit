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
}
