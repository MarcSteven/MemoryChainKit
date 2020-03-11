//
//  CGAffineTRansform+Extension.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/1/14.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit

// MARK: - Create CGAffineTransform that represents CGRect to CGRect
public extension CGAffineTransform {
    init(from :CGRect,to: CGRect) {
        self = CGAffineTransform(a: to.width / from.width, b: 0, c: 0, d: to.height / from.height, tx: to.midX - from.midX, ty: to.midY - from.midY)
    }
}
