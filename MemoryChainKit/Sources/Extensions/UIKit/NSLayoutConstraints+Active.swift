//
//  NSLayoutConstraints+Active.swift
//  MemoryChain
//
//  Created by Marc Zhao on 2018/8/4.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    @discardableResult func activate() ->NSLayoutConstraint {
        isActive = true
        return self 
    }
    }
