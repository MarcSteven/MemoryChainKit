//
//  NSLayoutAnchor+Extension.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/1/3.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit

@available(iOS 9.0,*)
public extension NSLayoutAnchor {
    @objc
    func constraint(equalTo   anchor:NSLayoutAnchor<AnchorType>,constant:CGFloat = 0 ) {
        constraint(equalTo: anchor, constant: constant).activate()
    }
    @objc
    func constrain(lessThanOrEqualTo anchor: NSLayoutAnchor<AnchorType>, constant: CGFloat = 0) {
        constraint(lessThanOrEqualTo: anchor, constant: constant).activate()
    }
    
    @objc
    func constrain(greaterThanOrEqualTo anchor: NSLayoutAnchor<AnchorType>, constant: CGFloat = 0) {
        constraint(greaterThanOrEqualTo: anchor, constant: constant).activate()
    }
}
