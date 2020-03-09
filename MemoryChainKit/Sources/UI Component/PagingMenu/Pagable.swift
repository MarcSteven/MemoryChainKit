//
//  Pagable.swift
//  MemoryChainKit
//
//  Created by Papi on 2019/5/30.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation

public protocol Pagable {
    var currentPage:Int {get}
    var previousPage:Int {get}
    var nextPage:Int {get}
    func update(currentPage page:Int)
}

extension Pagable {
    public  func update(currentPage page:Int) {}
}
