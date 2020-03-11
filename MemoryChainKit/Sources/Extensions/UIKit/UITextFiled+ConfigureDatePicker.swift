//
//  UITextFiled+ConfigureDatePicker.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/4/6.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit


public extension UITextField {
    func setupInputViewDataPicker(target:Any,selector:Selector) {
        
        let screenWidth = UIScreen.main.bounds.width
        let dataPicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
        dataPicker.datePickerMode = .date
        self.inputView = dataPicker
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancle = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel))
        let done = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
        toolBar.setItems([cancle,flexible,done], animated: false)
    }
    @objc func tapCancel() {
        self.resignFirstResponder()
    }
}
