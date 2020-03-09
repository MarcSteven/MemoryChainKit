//
//  UIView+Constraint.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/1/3.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit

@available(iOS 9.0, *)
extension UIView {
    public func addSubviewWithConstraints(fillingCompletely subView: UIView) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subView)
        subView.addConstraints(fillingSuperViewCompletely: self)
    }
    
    public func addConstraints(fillingSuperViewCompletely superView: UIView) {
    }
}
