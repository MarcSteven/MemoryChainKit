//
//  Anchor.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/10/10.
//  Copyright © 2020 Marc Steven(.com/MarcSteven). All rights reserved.
//

import UIKit

public class Anchor {
    private unowned var view:UIView
   public  init(view:UIView) {
        self.view = view
        
    }
    public private(set) lazy var top = YAxis(view: view, attribute: .top)
    public private(set) lazy var bottom = YAxis(view: view, attribute: .bottom)

    public private(set) lazy var leading = XAxis(view: view, attribute: .leading)
    public private(set) lazy var trailing = XAxis(view: view, attribute: .trailing)

    public private(set) lazy var width = DimensionAxis(view: view, attribute: .width)
    public private(set) lazy var height = DimensionAxis(view: view, attribute: .height)

    public private(set) lazy var centerX = XAxis(view: view, attribute: .centerX)
    public private(set) lazy var centerY = YAxis(view: view, attribute: .centerY)

    public private(set) lazy var firstBaseline = YAxis(view: view, attribute: .firstBaseline)
    public private(set) lazy var lastBaseline = YAxis(view: view, attribute: .lastBaseline)

    public private(set) lazy var edges = EdgesAxis(view: view, attribute: .edges)
    public private(set) lazy var size = SizeAxis(view: view, attribute: .size)
    public private(set) lazy var center = CenterAxis(view: view, attribute: .center)

    public private(set) lazy var vertically = YAxis(view: view, attribute: .vertical)
    public private(set) lazy var horizontally = XAxis(view: view, attribute: .horizontal)
}
public extension Anchor {
    func make(_ block:((Anchor) ->Void)) {
        block(self)
    }
}
extension Anchor.Axis {
    fileprivate func constraint(
        _ relation: NSLayoutConstraint.Relation,
        to other: Anchor.Axis<T>,
        safeAreaLayoutGuideOptions: SafeAreaLayoutGuideOptions = .none,
        file: StaticString = #file,
        line: UInt = #line
    ) -> [NSLayoutConstraint] {
        constraint(
            relation: relation,
            to: other.owningView,
            otherAttribute: other.attribute,
            safeAreaLayoutGuideOptions: safeAreaLayoutGuideOptions,
            file: file,
            line: line
        )
    }

    fileprivate func constraint(
        _ relation: NSLayoutConstraint.Relation,
        to otherView: UIView,
        safeAreaLayoutGuideOptions: SafeAreaLayoutGuideOptions = .none,
        file: StaticString = #file,
        line: UInt = #line
    ) -> [NSLayoutConstraint] {
        constraint(
            relation: relation,
            to: otherView,
            otherAttribute: attribute,
            safeAreaLayoutGuideOptions: safeAreaLayoutGuideOptions,
            file: file,
            line: line
        )
    }

    private func constraint(
        relation: NSLayoutConstraint.Relation,
        to otherView: UIView,
        otherAttribute: Anchor.Attributes,
        safeAreaLayoutGuideOptions: SafeAreaLayoutGuideOptions,
        file: StaticString = #file,
        line: UInt = #line
    ) -> [NSLayoutConstraint] {
        owningView.translatesAutoresizingMaskIntoConstraints = false

        var constraints: [NSLayoutConstraint] = []

        if attribute.contains(.top) {
            constraints.append(
                owningView.topAnchor.constraint(
                    relation,
                    anchor: otherAttribute.yAxisAnchor(
                        otherView,
                        safeAreaLayoutGuideOptions: safeAreaLayoutGuideOptions,
                        preferred: Anchor.Attributes.related(to: .top),
                        file: file,
                        line: line
                    )
                ).identifier("xc-anchor-top").anchorAttributes(.top)
            )
        }

        if attribute.contains(.bottom) {
            constraints.append(
                otherAttribute.yAxisAnchor(
                    otherView,
                    safeAreaLayoutGuideOptions: safeAreaLayoutGuideOptions,
                    preferred: Anchor.Attributes.related(to: .bottom),
                    file: file,
                    line: line
                ).constraint(
                    relation,
                    anchor: owningView.bottomAnchor
                ).identifier("xc-anchor-bottom").anchorAttributes(.bottom)
            )
        }

        if attribute.contains(.leading) {
            constraints.append(
                owningView.leadingAnchor.constraint(
                    relation,
                    anchor: otherAttribute.xAxisAnchor(
                        otherView,
                        safeAreaLayoutGuideOptions: safeAreaLayoutGuideOptions,
                        preferred: Anchor.Attributes.related(to: .leading),
                        file: file,
                        line: line
                    )
                ).identifier("xc-anchor-leading").anchorAttributes(.leading)
            )
        }

        if attribute.contains(.trailing) {
            constraints.append(
                otherAttribute.xAxisAnchor(
                    otherView,
                    safeAreaLayoutGuideOptions: safeAreaLayoutGuideOptions,
                    preferred: Anchor.Attributes.related(to: .trailing),
                    file: file,
                    line: line
                ).constraint(
                    relation,
                    anchor: owningView.trailingAnchor
                ).identifier("xc-anchor-trailing").anchorAttributes(.trailing)
            )
        }

        if attribute.contains(.width) {
            constraints.append(
                owningView.widthAnchor.constraint(
                    relation,
                    anchor: otherAttribute.dimensionAnchor(
                        otherView,
                        preferred: Anchor.Attributes.related(to: .width),
                        file: file,
                        line: line
                    )
                ).identifier("xc-anchor-width").anchorAttributes(.width)
            )
        }

        if attribute.contains(.height) {
            constraints.append(
                owningView.heightAnchor.constraint(
                    relation,
                    anchor: otherAttribute.dimensionAnchor(
                        otherView,
                        preferred: Anchor.Attributes.related(to: .height),
                        file: file,
                        line: line
                    )
                ).identifier("xc-anchor-height").anchorAttributes(.height)
            )
        }

        if attribute.contains(.centerX) {
            constraints.append(
                owningView.centerXAnchor.constraint(
                    relation,
                    anchor: otherAttribute.xAxisAnchor(
                        otherView,
                        safeAreaLayoutGuideOptions: safeAreaLayoutGuideOptions,
                        preferred: Anchor.Attributes.related(to: .centerX),
                        file: file,
                        line: line
                    )
                ).identifier("xc-anchor-center-x").anchorAttributes(.centerX)
            )
        }

        if attribute.contains(.centerY) {
            constraints.append(
                owningView.centerYAnchor.constraint(
                    relation,
                    anchor: otherAttribute.yAxisAnchor(
                        otherView,
                        safeAreaLayoutGuideOptions: safeAreaLayoutGuideOptions,
                        preferred: Anchor.Attributes.related(to: .centerY),
                        file: file,
                        line: line
                    )
                ).identifier("xc-anchor-center-y").anchorAttributes(.centerY)
            )
        }

        if attribute.contains(.firstBaseline) {
            constraints.append(
                owningView.firstBaselineAnchor.constraint(
                    relation,
                    anchor: otherAttribute.yAxisAnchor(
                        otherView,
                        safeAreaLayoutGuideOptions: safeAreaLayoutGuideOptions,
                        preferred: Anchor.Attributes.related(to: .firstBaseline),
                        file: file,
                        line: line
                    )
                ).identifier("xc-anchor-first-baseline").anchorAttributes(.firstBaseline)
            )
        }

        if attribute.contains(.lastBaseline) {
            constraints.append(
                owningView.lastBaselineAnchor.constraint(
                    relation,
                    anchor: otherAttribute.yAxisAnchor(
                        otherView,
                        safeAreaLayoutGuideOptions: safeAreaLayoutGuideOptions,
                        preferred: Anchor.Attributes.related(to: .lastBaseline),
                        file: file,
                        line: line
                    )
                ).identifier("xc-anchor-last-baseline").anchorAttributes(.lastBaseline)
            )
        }

        return constraints
    }
}

// MARK: Equal

extension Anchor.Axis {
    @discardableResult
    public func equalToSuperview(file: StaticString = #file, line: UInt = #line) -> Modifier {
        .init(constraints: constraint(.equal, to: owningView.superview!, file: file, line: line))
    }

    @discardableResult
    public func equalTo(_ other: Anchor.Axis<T>, file: StaticString = #file, line: UInt = #line) -> Modifier {
        .init(constraints: constraint(.equal, to: other, file: file, line: line))
    }

    @discardableResult
    public func equalTo(_ other: UIView, file: StaticString = #file, line: UInt = #line) -> Modifier {
        equalTo(copy(for: other), file: file, line: line)
    }
}

// MARK: LessThanOrEqual

extension Anchor.Axis {
    @discardableResult
    public func lessThanOrEqualToSuperview(file: StaticString = #file, line: UInt = #line) -> Modifier {
        .init(constraints: constraint(.lessThanOrEqual, to: owningView.superview!, file: file, line: line))
    }

    @discardableResult
    public func lessThanOrEqualTo(_ other: Anchor.Axis<T>, file: StaticString = #file, line: UInt = #line) -> Modifier {
        .init(constraints: constraint(.lessThanOrEqual, to: other, file: file, line: line))
    }

    @discardableResult
    public func lessThanOrEqualTo(_ other: UIView, file: StaticString = #file, line: UInt = #line) -> Modifier {
        lessThanOrEqualTo(copy(for: other), file: file, line: line)
    }
}

// MARK: GreaterThanOrEqual

extension Anchor.Axis {
    @discardableResult
    public func greaterThanOrEqualToSuperview(file: StaticString = #file, line: UInt = #line) -> Modifier {
        .init(constraints: constraint(.greaterThanOrEqual, to: owningView.superview!, file: file, line: line))
    }

    @discardableResult
    public func greaterThanOrEqualTo(_ other: Anchor.Axis<T>, file: StaticString = #file, line: UInt = #line) -> Modifier {
        .init(constraints: constraint(.greaterThanOrEqual, to: other, file: file, line: line))
    }

    @discardableResult
    public func greaterThanOrEqualTo(_ other: UIView, file: StaticString = #file, line: UInt = #line) -> Modifier {
        greaterThanOrEqualTo(copy(for: other), file: file, line: line)
    }
}

extension Anchor.EdgesAxis {
    @discardableResult
    public func equalToSuperviewSafeArea(file: StaticString = #file, line: UInt = #line) -> Modifier {
        .init(constraints: constraint(.equal, to: owningView.superview!, safeAreaLayoutGuideOptions: .all, file: file, line: line))
    }

    @discardableResult
    public func equalTo(_ safeArea: SafeAreaLayoutGuideOptions, file: StaticString = #file, line: UInt = #line) -> Modifier {
        .init(constraints: constraint(.equal, to: owningView.superview!, safeAreaLayoutGuideOptions: safeArea, file: file, line: line))
    }
}

extension Anchor.XAxis {
    @discardableResult
    public func equalToSuperviewSafeArea(file: StaticString = #file, line: UInt = #line) -> Modifier {
        .init(constraints: constraint(.equal, to: owningView.superview!, safeAreaLayoutGuideOptions: .all, file: file, line: line))
    }

    @discardableResult
    public func equalTo(_ safeArea: SafeAreaLayoutGuideOptions, file: StaticString = #file, line: UInt = #line) -> Modifier {
        .init(constraints: constraint(.equal, to: owningView.superview!, safeAreaLayoutGuideOptions: safeArea, file: file, line: line))
    }
}

extension Anchor.YAxis {
    @discardableResult
    public func equalToSuperviewSafeArea(file: StaticString = #file, line: UInt = #line) -> Modifier {
        .init(constraints: constraint(.equal, to: owningView.superview!, safeAreaLayoutGuideOptions: .all, file: file, line: line))
    }

    @discardableResult
    public func equalTo(_ safeArea: SafeAreaLayoutGuideOptions, file: StaticString = #file, line: UInt = #line) -> Modifier {
        .init(constraints: constraint(.equal, to: owningView.superview!, safeAreaLayoutGuideOptions: safeArea, file: file, line: line))
    }
}

extension Anchor.DimensionAxis {
    @discardableResult
    open func equalTo(_ value: CGFloat, file: StaticString = #file, line: UInt = #line) -> Modifier {
        equalTo(CGSize(value), file: file, line: line)

    }

    @discardableResult
    open func equalTo(_ value: CGSize, file: StaticString = #file, line: UInt = #line) -> Modifier {
        owningView.translatesAutoresizingMaskIntoConstraints = false

        var constraints: [NSLayoutConstraint] = []

        if attribute.contains(.width) {
            constraints.append(
                owningView.widthAnchor.constraint(equalToConstant: value.width).anchorAttributes(.width)
            )
        }

        if attribute.contains(.height) {
            constraints.append(
                owningView.heightAnchor.constraint(equalToConstant: value.height).anchorAttributes(.height)
            )
        }

        return .init(constraints: constraints)
    }
}

extension Anchor.DimensionAxis {
    @discardableResult
    open func greaterThanOrEqualTo(_ value: CGFloat, file: StaticString = #file, line: UInt = #line) -> Modifier {
        greaterThanOrEqualTo(CGSize(value), file: file, line: line)
    }

    @discardableResult
    open func greaterThanOrEqualTo(_ value: CGSize, file: StaticString = #file, line: UInt = #line) -> Modifier {
        owningView.translatesAutoresizingMaskIntoConstraints = false

        var constraints: [NSLayoutConstraint] = []

        if attribute.contains(.width) {
            constraints.append(
                owningView.widthAnchor.constraint(greaterThanOrEqualToConstant: value.width).anchorAttributes(.width)
            )
        }

        if attribute.contains(.height) {
            constraints.append(
                owningView.heightAnchor.constraint(greaterThanOrEqualToConstant: value.height).anchorAttributes(.height)
            )
        }

        return .init(constraints: constraints)
    }
}

extension Anchor.DimensionAxis {
    @discardableResult
    open func lessThanOrEqualTo(_ value: CGFloat, file: StaticString = #file, line: UInt = #line) -> Modifier {
        greaterThanOrEqualTo(CGSize(value), file: file, line: line)
    }

    @discardableResult
    open func lessThanOrEqualTo(_ value: CGSize, file: StaticString = #file, line: UInt = #line) -> Modifier {
        owningView.translatesAutoresizingMaskIntoConstraints = false

        var constraints: [NSLayoutConstraint] = []

        if attribute.contains(.width) {
            constraints.append(
                owningView.widthAnchor.constraint(lessThanOrEqualToConstant: value.width).anchorAttributes(.width)
            )
        }

        if attribute.contains(.height) {
            constraints.append(
                owningView.heightAnchor.constraint(lessThanOrEqualToConstant: value.height).anchorAttributes(.height)
            )
        }

        return .init(constraints: constraints)
    }
}
public extension Anchor {
    class Axis<T> {
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

    class XAxis: Axis<XAxisType> {}
    class YAxis: Axis<YAxisType> {}
    class DimensionAxis: Axis<DimensionAxisType> {}
    class SizeAxis: DimensionAxis {}
    class EdgesAxis: Axis<EdgesAxisType> {}
    class CenterAxis: Axis<CenterAxisType> {}

    enum XAxisType {}
    enum YAxisType {}
    enum DimensionAxisType {}
    enum EdgesAxisType {}
    enum CenterAxisType {}
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

            return inset(UIEdgeInsets( value))
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
