//
//  CGRect+Layout.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/16.
//  Copyright © 2020 Marc Steven(.com/MarcSteven). All rights reserved.
//

import UIKit

public extension CGRect {
    func layoutHeight(width spacing:CGFloat)->CGFloat {
        return height > 0 ? height + spacing : 0
    }
}
public extension CGRect {
     init(_ size: CGSize) {
        self = CGRect(origin: .zero, size: size)
    }
}
