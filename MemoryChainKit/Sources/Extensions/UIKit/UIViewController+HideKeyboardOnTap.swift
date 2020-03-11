//
//  UIViewController+HideKeyboardOnTap.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/5/11.
//  Copyright © 2019 Memory Chain network technology(Shenzhen) co,LTD. All rights reserved.
//

import UIKit

public extension UIViewController {
    /// Call this once to dismiss open keyboards by tapping anywhere in the view controller
    func hideKeyboardOnTap() {
        self.view.addGestureRecognizer(self.endEditingRecognizer())
        self.navigationController?.navigationBar.addGestureRecognizer(self.endEditingRecognizer())
    }
    
    /// Dismisses the keyboard from self.view
    private func endEditingRecognizer() -> UIGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        return tap
    }
}
//Usage : called this method of hideKeyboardOnTap in viewDidLoad()

