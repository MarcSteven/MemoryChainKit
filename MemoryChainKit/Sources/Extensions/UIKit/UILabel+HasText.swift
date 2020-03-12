//
//  UILabel+HasText.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2020/3/12.
//  Copyright © 2020 Marc Zhao(https://github.com/MarcSteven). All rights reserved.
//

import UIKit

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
