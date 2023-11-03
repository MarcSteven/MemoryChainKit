//
//  Box.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/24.
//  Copyright © 2020 Marc Steven(.com/MarcSteven). All rights reserved.
//

import Foundation

public final class Box<T> {
    let value:T
    init(_  value:T) {
        self.value = value
    }
}
