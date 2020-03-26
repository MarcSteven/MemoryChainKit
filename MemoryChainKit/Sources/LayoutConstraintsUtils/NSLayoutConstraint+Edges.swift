//  NSLayoutConstraint+Edges.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/1/3.
//  Copyright © 2019 Memory Chain technology(Shenzhen) co,LTD. All rights reserved.
//
import UIKit

extension NSLayoutConstraint {
    public struct Edges {
        public let top: NSLayoutConstraint
        public let bottom: NSLayoutConstraint
        public let leading: NSLayoutConstraint
        public let trailing: NSLayoutConstraint

        private var constraints: [NSLayoutConstraint] {
            [top, bottom, leading, trailing]
        }

        init(_ constraints: [NSLayoutConstraint]) {
            trailing = constraints[0]
            leading = constraints[1]
            bottom = constraints[2]
            top = constraints[3]
        }

        public init(top: NSLayoutConstraint, bottom: NSLayoutConstraint, leading: NSLayoutConstraint, trailing: NSLayoutConstraint) {
            self.top = top
            self.bottom = bottom
            self.leading = leading
            self.trailing = trailing
        }

        public mutating func update(from insets: UIEdgeInsets) {
            top.constant = insets.top
            bottom.constant = insets.bottom
            leading.constant = insets.left
            trailing.constant = insets.right
        }

        public mutating func update(from value: CGFloat) {
            top.constant = value
            bottom.constant = value
            leading.constant = value
            trailing.constant = value
        }

        public func activate() {
            constraints.activate()
        }

        public func deactivate() {
            constraints.deactivate()
        }
    }

    public struct Size {
        public let width: NSLayoutConstraint
        public let height: NSLayoutConstraint

        private var constraints: [NSLayoutConstraint] {
            [width, height]
        }

        init(_ constraints: [NSLayoutConstraint]) {
            width = constraints[0]
            height = constraints[1]
        }

        public init(width: NSLayoutConstraint, height: NSLayoutConstraint) {
            self.width = width
            self.height = height
        }

        public mutating func update(from size: CGSize) {
            width.constant = size.width
            height.constant = size.height
        }

        public mutating func update(from value: CGFloat) {
            width.constant = value
            height.constant = value
        }

        public func toggleIfNeeded() {
            width.isActive = width.constant != 0
            height.isActive = height.constant != 0
        }

        public func activate() {
            constraints.activate()
        }

        public func deactivate() {
            constraints.deactivate()
        }
    }
}
