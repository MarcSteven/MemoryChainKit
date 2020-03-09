//
//  UICollectionExtension.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2020/3/9.
//  Copyright © 2020 Marc Zhao(https://github.com/MarcSteven). All rights reserved.
//

import Foundation

public extension Collection {
    subscript(safe index:Index) ->Iterator.Element? {
        return index >= startIndex &&  index < endIndex ? self[index] : nil
    }
}
