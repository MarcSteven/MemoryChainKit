//
//  UINavigationBar+Style.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/14.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import UIKit

extension UINavigationBar {
    func apply(_ style:Stylable) {
        applyColors(barColor:style.barColor , barTintColor: style.tintColor)
    }
    func applyColors(barColor:UIColor?,
                     barTintColor:UIColor) {
        self.isTranslucent = false
        self.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor:barTintColor
        ]
        self.tintColor = barTintColor
        self.barTintColor = barTintColor
        guard #available(iOS 11.0, *) else {return }
            self.largeTitleTextAttributes = [
                NSAttributedString.Key.foregroundColor:barTintColor
            ]
        
    }
    func setTitleFont(_ font:UIFont) {
        titleTextAttributes = [.font:font]
    }
    func setTitleColor(_ color:UIColor) {
        titleTextAttributes = [.foregroundColor:color]
    }
    func makeTransparent() {
        isTranslucent = true
        backgroundColor = .clear
        barTintColor = .clear
        setBackgroundImage(UIImage(), for: .default)
        shadowImage = UIImage()
    }
    
}
