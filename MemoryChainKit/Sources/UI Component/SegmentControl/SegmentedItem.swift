//
//  SegmentedItem.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/1/28.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation

private let padding:CGFloat = 5
private let badgeMargin:CGFloat = 5


open class SegmentedItem:UIButton {
    var title:String? {
        didSet {
            
        }
    }
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
