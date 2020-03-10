//
//  CGSize+Extension.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/1/29.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation


extension CGSize :ExpressibleByFloatLiteral{
    public typealias FloatLiteralType = Double
    public init(size:Double) {
        self.init(width: size, height: size)
    }
    public init(floatLiteral value:FloatLiteralType) {
        self.init(size: value)
    }
    var aspectRatio:CGFloat {
        return width / height
    }
    func sizeByDelta(dw:CGFloat,
                     dh:CGFloat) ->CGSize {
        return CGSize(self.width + dw,self.height + dh)
    }
    init(_ width:CGFloat,
         _ height:CGFloat) {
        self.init(width, height)
    }
}
