//
//  CGSizeExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/10/11.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import UIKit

// MARK: - CGSize - ExpressibleByFloatLiteral

extension CGSize: ExpressibleByFloatLiteral {
    public init(floatLiteral value: FloatLiteralType) {
        let value = CGFloat(value)
        self = CGSize(width: value, height: value)
    }
}

// MARK: - CGSize - ExpressibleByIntegerLiteral

extension CGSize: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: IntegerLiteralType) {
        let value = CGFloat(value)
        self = CGSize(width: value, height: value)
    }
}

// MARK: - CGSize - Extensions

extension CGSize {
    /// Returns the lesser of width and height.
    public var min: CGFloat {
        Swift.min(width, height)
    }

    /// Returns the greater of width and height.
    public var max: CGFloat {
        Swift.max(width, height)
    }
}

extension CGSize {
    public init(_ value: CGFloat) {
        self = CGSize(width: value, height: value)
    }

    public static func +=(lhs: inout CGSize, rhs: CGSize) {
        lhs.width += rhs.width
        lhs.height += rhs.height
    }

    public static func +=(lhs: inout CGSize, rhs: CGFloat) {
        lhs = lhs + rhs
    }

    public static func +(lhs: CGSize, rhs: CGSize) -> CGSize {
        .init(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }

    public static func +(lhs: CGSize, rhs: CGFloat) -> CGSize {
        .init(width: lhs.width + rhs, height: lhs.height + rhs)
    }
}

extension CGSize {
    public static func -=(lhs: inout CGSize, rhs: CGSize) {
        lhs.width -= rhs.width
        lhs.height -= rhs.height
    }

    public static func -=(lhs: inout CGSize, rhs: CGFloat) {
        lhs = lhs - rhs
    }

    public static func -(lhs: CGSize, rhs: CGSize) -> CGSize {
        .init(width: lhs.width - rhs.width, height: lhs.height - rhs.height)
    }

    public static func -(lhs: CGSize, rhs: CGFloat) -> CGSize {
        .init(width: lhs.width - rhs, height: lhs.height - rhs)
    }
}

extension CGSize {
    public static func *=(lhs: inout CGSize, rhs: CGSize) {
        lhs.width *= rhs.width
        lhs.height *= rhs.height
    }

    public static func *=(lhs: inout CGSize, rhs: CGFloat) {
        lhs = lhs * rhs
    }

    public static func *(lhs: CGSize, rhs: CGSize) -> CGSize {
        .init(width: lhs.width * rhs.width, height: lhs.height * rhs.height)
    }

    public static func *(lhs: CGSize, rhs: CGFloat) -> CGSize {
        .init(width: lhs.width * rhs, height: lhs.height * rhs)
    }
}
