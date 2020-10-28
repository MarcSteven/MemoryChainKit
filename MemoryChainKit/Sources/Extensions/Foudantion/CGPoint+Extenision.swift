//
//  CGPoint+Extenision.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/1/29.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation
import UIKit


extension CGPoint {
    init(_ x:CGFloat,
         _ y:CGFloat) {
        self.init(x, y)
    }
}

public extension CGPoint {
    func distance(to point:CGPoint) ->CGFloat {
        return hypot(self.x - point.x, self.y - point.y)
    }
}
