//
//  Anchor+Axis.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/1/3.
//  Copyright © 2019 Memory Chain technology(Shenzhen) co,LTD. All rights reserved.
//


import UIKit


// MARK: Axis

extension Anchor {
    public class Axis<T> {
        fileprivate unowned var owningView: UIView
        fileprivate var attribute: Attributes

        init(view: UIView, attribute: Attributes) {
            self.owningView = view
            self.attribute = attribute
        }

        fileprivate func copy(for view: UIView) -> Axis<T> {
            .init(view: view, attribute: attribute)
        }
    }

    public class XAxis: Axis<XAxisType> {}
    public class YAxis: Axis<YAxisType> {}
    public class DimensionAxis: Axis<DimensionAxisType> {}
    public class SizeAxis: DimensionAxis {}
    public class EdgesAxis: Axis<EdgesAxisType> {}
    public class CenterAxis: Axis<CenterAxisType> {}

    public enum XAxisType {}
    public enum YAxisType {}
    public enum DimensionAxisType {}
    public enum EdgesAxisType {}
    public enum CenterAxisType {}
}



extension Anchor.Axis {
    public class Modifier {
        public var constraints: [NSLayoutConstraint]
        private var constant = 0
        private var priority: UILayoutPriority = .required

        fileprivate init(constraints: [NSLayoutConstraint]) {
            self.constraints = constraints
            constraints.activate()
        }

        /// A convenience method to set layout priority.
        ///
        /// - Parameter value: The layout priority.
        /// - Returns: `self`.
        @discardableResult
        public func priority(_ value: UILayoutPriority) -> Modifier {
            for (index, constraint) in constraints.reversed().enumerated() {
                guard constraint.priority.rawValue > value.rawValue else {
                    constraint.priority = value
                    continue
                }

                constraints[index] = constraint.createWithPriority(value)
            }
            return self
        }

        /// A convenience method to set layout multiplier.
        ///
        /// - Parameter value: The layout multiplier.
        /// - Returns: `self`.
        @discardableResult
        func multiplier(_ value: CGFloat) -> Modifier {
            for (index, constraint) in constraints.reversed().enumerated() {
                guard constraint.multiplier != value else {
                    continue
                }

                constraints[index] = constraint.createWithMultiplier(value)
            }
            return self
        }

        /// A convenience method to set inset.
        ///
        /// - Parameter value: The inset value.
        /// - Returns: `self`.
        @discardableResult
        public func inset(_ value: CGFloat) -> Modifier {
            constraints.forEach {
                $0.constant = value
            }

            return inset(UIEdgeInsets(value))
        }

        /// A convenience method to set inset.
        ///
        /// - Parameter value: The inset value.
        /// - Returns: `self`.
        @discardableResult
        public func inset(_ value: UIEdgeInsets) -> Modifier {
            constraints.firstAttribute(.top)?.constant = value.top
            constraints.firstAttribute(.bottom)?.constant = value.bottom
            constraints.firstAttribute(.leading)?.constant = value.left
            constraints.firstAttribute(.trailing)?.constant = value.right
            return self
        }

        /// Activates each constraint in `self`.
        ///
        /// A convenience method provides an easy way to activate a set of constraints
        /// with one call. The effect of this method is the same as setting the `active`
        /// property of each constraint to `true`.
        ///
        /// Typically, using this method is more efficient than activating each
        /// constraint individually.
        ///
        /// - Returns: `self`.
        @discardableResult
        public func activate() -> Modifier {
            constraints.activate()
            return self
        }

        /// Deactivates each constraint in `self`.
        ///
        /// A convenience method that provides an easy way to deactivate a set of
        /// constraints with one call. The effect of this method is the same as setting
        /// the `active` property of each constraint to `false`.
        ///
        /// Typically, using this method is more efficient than deactivating each
        /// constraint individually.
        ///
        /// - Returns: `self`.
        @discardableResult
        public func deactivate() -> Modifier {
            constraints.deactivate()
            return self
        }
    }
}
