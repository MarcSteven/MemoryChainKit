//
//  NSLayoutAnchorExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/10/10.
//  Copyright © 2020 Marc Steven(.com/MarcSteven). All rights reserved.
//

import UIKit


@objc
public extension NSLayoutAnchor {
    func constraint(_ relation:NSLayoutConstraint.Relation,
                    anchor:NSLayoutAnchor) ->NSLayoutConstraint {
        switch relation {
        case .equal:
            return constraint(equalTo: anchor)
        case .lessThanOrEqual:
            return constraint(lessThanOrEqualTo: anchor)
        case .greaterThanOrEqual:
            return constraint(greaterThanOrEqualTo: anchor)
            
        default:
            fatalError(because: .unknownCaseDetected(relation))
        }
    }
}
