//
//  CAtranscationExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/19.
//  Copyright © 2020 Marc Steven(.com/MarcSteven). All rights reserved.
//

import QuartzCore
import UIKit

extension CATransaction {
    public static func animation(_ animations:() ->Void,completinonHandler:(() ->Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completinonHandler)
        animations()
        CATransaction.commit()
        
    }
    public static func performWithoutAnimation(_ actionsWithouAnimation:()->Void) {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        actionsWithouAnimation()
        CATransaction.commit()
    }
}
extension CATransitionType {
    public static let none = CATransitionType(rawValue: "")
    
}
