//
//  Reusable.swift
//  MemoryChain
//
//  Created by Marc Zhao on 2018/8/4.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation
import UIKit

public protocol Reusable :class{
    static var reuseIdentifier:String {get}
    static var nib:UINib? { get }
}
extension Reusable {
    public static var reuseIdentifier:String {
        return String(describing: self)
    }
    public static var nib:UINib? {
        return nil
    }
}
extension UITableViewCell:Reusable {}

extension UICollectionViewCell:Reusable {}

