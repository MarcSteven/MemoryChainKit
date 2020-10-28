//
//  DimmableLayout.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/10/28.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import UIKit


public protocol DimmableLayout: UICollectionViewLayout {
    var shouldDimElements: Bool { get set }
}

