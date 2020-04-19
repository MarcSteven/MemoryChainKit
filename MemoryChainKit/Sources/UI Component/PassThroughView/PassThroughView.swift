/
// MemoryChainKit
// Copyright © 2019 Marc Steven
// MIT license, see LICENSE file for details
//

import UIKit

/// Pass UI events through the stack view.
///
/// - Note: It won't pass touch events to any subviews that have
/// `isUserInteractionEnabled` flag set to `false`.
open class PassthroughView: UIView {
    private var _ignoreTouchesPrecondition: () -> Bool = { true }

    /// A method to check certain condition for ignoring touches.
    open func ignoreTouchesPrecondition(_ condition: @escaping () -> Bool) {
        _ignoreTouchesPrecondition = condition
    }

    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let view = super.hitTest(point, with: event), view != self else {
            return nil
        }

        return _ignoreTouchesPrecondition() ? nil : view
    }
}

/// Pass UI events through the view.
///
/// - Note: It won't pass touch events to any subviews that have
/// `isUserInteractionEnabled` flag set to `false`.
open class PassthroughStackView: UIStackView {
    private var _ignoreTouchesPrecondition: () -> Bool = { true }

    /// A method to check certain condition for ignoring touches.
    open func ignoreTouchesPrecondition(_ condition: @escaping () -> Bool) {
        _ignoreTouchesPrecondition = condition
    }

    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let view = super.hitTest(point, with: event), view != self else {
            return nil
        }

        return _ignoreTouchesPrecondition() ? nil : view
    }
}

