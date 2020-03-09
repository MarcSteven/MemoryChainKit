//
//  UIView+Constraints.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2020/3/9.
//  Copyright © 2020 Marc Zhao(https://github.com/MarcSteven). All rights reserved.
//

import UIKit

public extension UIView {
    func findViewController() ->UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        }else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        }else {
            return nil
        }
    }
    func addConstraintsWithFormat(_ format:String,views:UIView...) {
        var viewDictionary = [String:UIView]()
        for (index,view)in views.enumerated() {
            let key = "v\(index)"
            viewDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
            
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewDictionary))
    }
}