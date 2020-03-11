//
//   UIViewPropertyAnimator+Extension.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/3/10.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation
import UIKit

public extension UIViewPropertyAnimator {
    func addNext(_ animation:UIViewPropertyAnimator) {
        self.addCompletion { position in
            guard position == .end else {
                return
            }
            animation.startAnimation()
        }
    }
}
