//
//  CGSizeExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/10/11.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import UIKit

// MARK: - CGSize - ExpressibleByFloatLiteral

public extension CGSize: ExpressibleByFloatLiteral {
     init(floatLiteral value: FloatLiteralType) {
        let value = CGFloat(value)
        self = CGSize(width: value, height: value)
    }
}

// MARK: - CGSize - ExpressibleByIntegerLiteral

public extension CGSize: ExpressibleByIntegerLiteral {
     init(integerLiteral value: IntegerLiteralType) {
        let value = CGFloat(value)
        self = CGSize(width: value, height: value)
    }
}

// MARK: - CGSize - Extensions

public extension CGSize {
    /// Returns the lesser of width and height.
     var min: CGFloat {
        Swift.min(width, height)
    }

    /// Returns the greater of width and height.
     var max: CGFloat {
        Swift.max(width, height)
    }
}

public extension CGSize {
     init(_ value: CGFloat) {
        self = CGSize(width: value, height: value)
    }

    static func +=(lhs: inout CGSize, rhs: CGSize) {
        lhs.width += rhs.width
        lhs.height += rhs.height
    }

     static func +=(lhs: inout CGSize, rhs: CGFloat) {
        lhs = lhs + rhs
    }

     static func +(lhs: CGSize, rhs: CGSize) -> CGSize {
        .init(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }

     static func +(lhs: CGSize, rhs: CGFloat) -> CGSize {
        .init(width: lhs.width + rhs, height: lhs.height + rhs)
    }
}

public extension CGSize {
     static func -=(lhs: inout CGSize, rhs: CGSize) {
        lhs.width -= rhs.width
        lhs.height -= rhs.height
    }

     static func -=(lhs: inout CGSize, rhs: CGFloat) {
        lhs = lhs - rhs
    }

     static func -(lhs: CGSize, rhs: CGSize) -> CGSize {
        .init(width: lhs.width - rhs.width, height: lhs.height - rhs.height)
    }

     static func -(lhs: CGSize, rhs: CGFloat) -> CGSize {
        .init(width: lhs.width - rhs, height: lhs.height - rhs)
    }
}

public extension CGSize {
     static func *=(lhs: inout CGSize, rhs: CGSize) {
        lhs.width *= rhs.width
        lhs.height *= rhs.height
    }

     static func *=(lhs: inout CGSize, rhs: CGFloat) {
        lhs = lhs * rhs
    }

     static func *(lhs: CGSize, rhs: CGSize) -> CGSize {
        .init(width: lhs.width * rhs.width, height: lhs.height * rhs.height)
    }

     static func *(lhs: CGSize, rhs: CGFloat) -> CGSize {
        .init(width: lhs.width * rhs, height: lhs.height * rhs)
    }
}
