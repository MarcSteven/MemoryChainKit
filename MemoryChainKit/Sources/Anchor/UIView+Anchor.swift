//
//  UIView+Anchor.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/10/11.
//  Copyright © 2020 Marc Steven(.com/MarcSteven). All rights reserved.
//

import UIKit

public extension UIView {
    private struct AssociatedKey {
        static var anchor = "anchor"
    }
    var anchor:Anchor {
        associatedObject(&AssociatedKey.anchor, default: Anchor(view:self),policy: .strong)
    }
}
