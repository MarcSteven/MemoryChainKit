//
//  Stylable.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/3/2.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit

public protocol Stylable {}
extension UIView:Stylable {}
public struct ViewStyle<T> {
    let style:(T)->Void
}
extension Stylable {
    
    func apply(_ style:ViewStyle<Self>) {
        style.style(self)
    }
   
}
