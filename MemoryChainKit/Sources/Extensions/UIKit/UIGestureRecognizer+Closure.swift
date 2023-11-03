//
//  UIGestureRecognizer+Closure.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/10/11.
//  Copyright © 2020 Marc Steven(.com/MarcSteven). All rights reserved.
//

import UIKit
import ObjectiveC

public protocol TargetActionBlockRepresentable: class {
    associatedtype Sender

    /// Add action handler when the item is selected.
    ///
    /// - Parameter handler: The block to invoke when the item is selected.
    func addAction(_ handler: @escaping (_ sender: Sender) -> Void)

    /// Removes action handler from `self`.
    func removeAction()
}

@objcMembers
class ClosureWrapper: NSObject {
    var closure: (() -> Void)?

    init(_ closure: (() -> Void)?) {
        self.closure = closure
    }

    func invoke(_ sender: AnyObject) {
        closure?()
    }
}

@objcMembers
class SenderClosureWrapper: NSObject {
    var closure: ((_ sender: AnyObject) -> Void)?

    init(_ closure: ((_ sender: AnyObject) -> Void)?) {
        self.closure = closure
    }

    func invoke(_ sender: AnyObject) {
        closure?(sender)
    }
}
extension UIGestureRecognizer:TargetActionBlockRepresentable {
    public typealias Sender = UIGestureRecognizer

        private struct AssociatedKey {
            static var actionHandler = "actionHandler"
        }

        fileprivate var actionHandler: SenderClosureWrapper? {
            get { associatedObject(&AssociatedKey.actionHandler) }
            set { setAssociatedObject(&AssociatedKey.actionHandler, value: newValue) }
        }
    }

    extension TargetActionBlockRepresentable where Self: UIGestureRecognizer {
        private func setActionHandler(_ handler: ((_ sender: Self) -> Void)?) {
            guard let handler = handler else {
                actionHandler = nil
                removeTarget(nil, action: nil)
                return
            }

            let wrapper = SenderClosureWrapper(nil)

            wrapper.closure = { sender in
                guard let sender = sender as? Self else { return }
                handler(sender)
            }

            actionHandler = wrapper
            addTarget(wrapper, action: #selector(wrapper.invoke(_:)))
        }

        /// Add action handler when the item is selected.
        ///
        /// - Parameter handler: The block to invoke when the item is selected.
        public func addAction(_ handler: @escaping (_ sender: Self) -> Void) {
            setActionHandler(handler)
        }

        /// Removes action handler from `self`.
        public func removeAction() {
            setActionHandler(nil)
        }

        /// A boolean value to determine whether an action handler is attached.
        public var hasActionHandler: Bool {
            actionHandler != nil
        }

        public init(_ handler: @escaping (_ sender: Self) -> Void) {
            self.init()
            setActionHandler(handler)
        }
    }

