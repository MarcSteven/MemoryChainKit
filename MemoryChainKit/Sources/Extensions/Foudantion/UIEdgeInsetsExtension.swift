//
//  UIEdgeInsetsExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/10/11.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation
import UIKit

// MARK: - UIEdgeInsets - ExpressibleByFloatLiteral

extension UIEdgeInsets: ExpressibleByFloatLiteral {
    public init(floatLiteral value: FloatLiteralType) {
        self = UIEdgeInsets(CGFloat(value))
    }
}

// MARK: - UIEdgeInsets - ExpressibleByIntegerLiteral

extension UIEdgeInsets: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: IntegerLiteralType) {
        self = UIEdgeInsets(CGFloat(value))
    }
}

// MARK: - UIEdgeInsets - Extensions

extension UIEdgeInsets {
    public init(_ value: CGFloat) {
        self = UIEdgeInsets(top: value, left: value, bottom: value, right: value)
    }

    public init(top: CGFloat) {
        self = UIEdgeInsets(top: top, left: 0, bottom: 0, right: 0)
    }

    public init(left: CGFloat) {
        self = UIEdgeInsets(top: 0, left: left, bottom: 0, right: 0)
    }

    public init(bottom: CGFloat) {
        self = UIEdgeInsets(top: 0, left: 0, bottom: bottom, right: 0)
    }

    public init(right: CGFloat) {
        self = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: right)
    }

    public init(horizontal: CGFloat, vertical: CGFloat) {
        self = UIEdgeInsets(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }

    public init(horizontal: CGFloat) {
        self = UIEdgeInsets(top: 0, left: horizontal, bottom: 0, right: horizontal)
    }

    public init(horizontal: CGFloat, top: CGFloat) {
        self = UIEdgeInsets(top: top, left: horizontal, bottom: 0, right: horizontal)
    }

    public init(horizontal: CGFloat, bottom: CGFloat) {
        self = UIEdgeInsets(top: 0, left: horizontal, bottom: bottom, right: horizontal)
    }

    public init(vertical: CGFloat) {
        self = UIEdgeInsets(top: vertical, left: 0, bottom: vertical, right: 0)
    }

    public init(vertical: CGFloat, left: CGFloat) {
        self = UIEdgeInsets(top: vertical, left: left, bottom: vertical, right: 0)
    }

    public init(vertical: CGFloat, right: CGFloat) {
        self = UIEdgeInsets(top: vertical, left: 0, bottom: vertical, right: right)
    }

    public var horizontal: CGFloat {
        get { left + right }
        set {
            left = newValue
            right = newValue
        }
    }

    public var vertical: CGFloat {
        get { top + bottom }
        set {
            top = newValue
            bottom = newValue
        }
    }
}

extension UIEdgeInsets {
    public static func +=(lhs: inout UIEdgeInsets, rhs: UIEdgeInsets) {
        lhs.top    += rhs.top
        lhs.left   += rhs.left
        lhs.bottom += rhs.bottom
        lhs.right  += rhs.right
    }

    public static func +=(lhs: inout UIEdgeInsets, rhs: CGFloat) {
        lhs.horizontal = rhs
        lhs.vertical = rhs
    }

    public static func +(lhs: UIEdgeInsets, rhs: UIEdgeInsets) -> UIEdgeInsets {
        .init(
            top: lhs.top + rhs.top,
            left: lhs.left + rhs.left,
            bottom: lhs.bottom + rhs.bottom,
            right: lhs.right + rhs.right
        )
    }

    public static func +(lhs: UIEdgeInsets, rhs: CGFloat) -> UIEdgeInsets {
        .init(
            top: lhs.top + rhs,
            left: lhs.left + rhs,
            bottom: lhs.bottom + rhs,
            right: lhs.right + rhs
        )
    }
}

extension UIEdgeInsets {
    public static func -=(lhs: inout UIEdgeInsets, rhs: UIEdgeInsets) {
        lhs.top    -= rhs.top
        lhs.left   -= rhs.left
        lhs.bottom -= rhs.bottom
        lhs.right  -= rhs.right
    }

    public static func -=(lhs: inout UIEdgeInsets, rhs: CGFloat) {
        lhs.top    -= rhs
        lhs.left   -= rhs
        lhs.bottom -= rhs
        lhs.right  -= rhs
    }

    public static func -(lhs: UIEdgeInsets, rhs: UIEdgeInsets) -> UIEdgeInsets {
        .init(
            top: lhs.top - rhs.top,
            left: lhs.left - rhs.left,
            bottom: lhs.bottom - rhs.bottom,
            right: lhs.right - rhs.right
        )
    }

    public static func -(lhs: UIEdgeInsets, rhs: CGFloat) -> UIEdgeInsets {
        .init(
            top: lhs.top - rhs,
            left: lhs.left - rhs,
            bottom: lhs.bottom - rhs,
            right: lhs.right - rhs
        )
    }
}

public extension UIEdgeInsets {
    var flippedForRightToLeft: UIEdgeInsets {
        guard UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft else {
            return self
        }
        
        return flippedForRightToLeftLayoutDirection()
    }
    
    func flippedForRightToLeftLayoutDirection() -> UIEdgeInsets {
        return UIEdgeInsets(top: top, left: right, bottom: bottom, right: left)
    }
    
    init(allEdges: CGFloat) {
        self.init(top: allEdges, left: allEdges, bottom: allEdges, right: allEdges)
    }
}
