//
//  UISegmentedControlExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/11/9.
//  Copyright © 2020 Marc Steven(.com/MarcSteven). All rights reserved.
//


import  UIKit

public extension UISegmentedControl {
    
    var segmentTitles:[String] {
        get {
            let range = 0..<numberOfSegments
            return range.compactMap { titleForSegment(at: $0) }
        }
        set {
            removeAllSegments()
            for (index, title) in newValue.enumerated() {
                insertSegment(withTitle: title, at: index, animated: false)
            }
    }
    }
}
