//
//  NSLayoutConstraint+Debugging.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/1/5.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit
public extension NSLayoutConstraint {
//    Report ambiguity constraint here
    class func reportAmbiguity(_ view:UIView?) {
        var v = view
        if v == nil {
            v = UIApplication.shared.keyWindow
        }
        for vv in v!.subviews {
            print("\(vv.hasAmbiguousLayout)")
            if vv.subviews.count > 0 {
                self.reportAmbiguity(vv)
            }
        }
        
    }
//    List all the constraints here
    class func listConstraints(_ view:UIView?) {
        var v = view
        if v == nil {
            v = UIApplication.shared.keyWindow
            
        }
        for vv in v!.subviews {
            let arr1 = vv.constraintsAffectingLayout(for: .horizontal)
            let arr2 = vv.constraintsAffectingLayout(for: .vertical)
            print("\n\n%@\nH: %@\nV: %@",vv,arr1,arr2)
            if vv.subviews.count > 0 {
                self.listConstraints(vv)
            }
        }
    }
}
