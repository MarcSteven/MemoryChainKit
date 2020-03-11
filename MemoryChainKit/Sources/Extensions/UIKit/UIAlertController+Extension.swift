//
//  UIAlertController+Extension.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/6/13.
//  Copyright © 2019 Memory Chain network technology(Shenzhen) co,LTD. All rights reserved.
//

import Foundation
import UIKit


public extension UIAlertController {
    func setBackgroundColorForAlertController(_ color:UIColor) {
        if let backgroundView = self.view.subviews.first,
        let groupView = backgroundView.subviews.first,
            let contentView = groupView.subviews.first {
            contentView.backgroundColor = color
        }
    }
    func setTitleFontAndColorForAlertController(_ font:UIFont?,
                                                color:UIColor?) {
        guard let title = self.title else {
            return
        }
        let attributeString = NSMutableAttributedString(string: title)
        if let titleFont = font {
            attributeString.addAttributes([NSAttributedString.Key.font:titleFont], range: NSMakeRange(0, title.utf8.count))
        }
        if let titleColor = color {
            attributeString.addAttributes([NSAttributedString.Key.foregroundColor:titleColor], range: NSMakeRange(0, title.utf8.count))
        }
        self.setValue(attributeString, forKey: "attributedTitle")
    }
    // set message font and message color
    func setMessageFontAndColorForAlertController(_ font:UIFont?,
                                                  color:UIColor?) {
        guard let title = self.message else {
            return
        }
        let attributedString = NSMutableAttributedString(string: title)
        if let titleFont = font {
            attributedString.addAttributes([NSAttributedString.Key.font:titleFont], range: NSMakeRange(0, title.utf8.count))
        }
        if let titleColor = color {
            attributedString.addAttributes([NSAttributedString.Key.foregroundColor:titleColor], range: NSMakeRange(0, title.utf8.count))
        }
        self.setValue(attributedString, forKey: "attributedMessage")
    }
    // set tintColor for AlertController
    func setTintColorForAlertController(_ color:UIColor) {
        self.view.tintColor = color
    }
}
