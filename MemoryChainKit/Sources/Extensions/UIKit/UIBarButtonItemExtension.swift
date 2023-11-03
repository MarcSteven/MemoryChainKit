//
//  UIBarButtonItemExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/18.
//  Copyright © 2020 Marc Steven(.com/MarcSteven). All rights reserved.
//

import UIKit

// MARK: TextColor

extension UIBarButtonItem {
    @objc open dynamic var textColor: UIColor? {
        get { titleTextColor(for: .normal) }
        set { setTitleTextColor(newValue, for: .normal) }
    }

    open func titleTextColor(for state: UIControl.State) -> UIColor? {
        return titleTextAttribute(.foregroundColor, for: state)
    }

    open func setTitleTextColor(_ color: UIColor?, for state: UIControl.State) {
        setTitleTextAttribute(.foregroundColor, value: color, for: state)
    }
}

// MARK: Font

extension UIBarButtonItem {
    @objc open dynamic var font: UIFont? {
        get { titleTextFont(for: .normal) }
        set {
            UIControl.State.applicationStates.forEach {
                setTitleTextFont(newValue, for: $0)
            }
        }
    }

    open func titleTextFont(for state: UIControl.State) -> UIFont? {
        titleTextAttribute(.font, for: state)
    }

    open func setTitleTextFont(_ font: UIFont?, for state: UIControl.State) {
        setTitleTextAttribute(.font, value: font, for: state)
    }
}

// MARK: Helpers

extension UIBarButtonItem {
    private func titleTextAttribute<T>(_ key: NSAttributedString.Key, for state: UIControl.State) -> T? {
        titleTextAttributes(for: state)?[key] as? T
    }

    private func setTitleTextAttribute(_ key: NSAttributedString.Key, value: Any?, for state: UIControl.State) {
        var attributes = titleTextAttributes(for: state) ?? [:]
        attributes[key] = value
        setTitleTextAttributes(attributes, for: state)
    }
}

extension UIControl.State {
    fileprivate static var applicationStates: [UIControl.State] {
        [.normal, .highlighted, .disabled, .selected, .focused, .application]
    }
}
extension UIBarButtonItem: TargetActionBlockRepresentable {
    public typealias Sender = UIBarButtonItem

    private struct AssociatedKey {
        static var actionHandler = "actionHandler"
    }

    fileprivate var actionHandler: SenderClosureWrapper? {
        get { associatedObject(&AssociatedKey.actionHandler) }
        set { setAssociatedObject(&AssociatedKey.actionHandler, value: newValue) }
    }
}

extension TargetActionBlockRepresentable where Self: UIBarButtonItem {
    private func setActionHandler(_ handler: ((_ sender: Self) -> Void)?) {
        guard let handler = handler else {
            actionHandler = nil
            target = nil
            action = nil
            return
        }

        let wrapper = SenderClosureWrapper(nil)

        wrapper.closure = { sender in
            guard let sender = sender as? Self else { return }
            handler(sender)
        }

        actionHandler = wrapper
        target = wrapper
        action = #selector(wrapper.invoke(_:))
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

    public init(image: UIImage?, landscapeImagePhone: UIImage? = nil, style: UIBarButtonItem.Style = .plain, _ handler: ((_ sender: Self) -> Void)? = nil) {
        self.init(image: image, landscapeImagePhone: landscapeImagePhone, style: style, target: nil, action: nil)
        setActionHandler(handler)
    }

    public init(title: String?, style: UIBarButtonItem.Style = .plain, _ handler: ((_ sender: Self) -> Void)? = nil) {
        self.init(title: title, style: style, target: nil, action: nil)
        setActionHandler(handler)
    }

    public init(barButtonSystemItem systemItem: UIBarButtonItem.SystemItem, _ handler: ((_ sender: Self) -> Void)? = nil) {
        self.init(barButtonSystemItem: systemItem, target: nil, action: nil)
        setActionHandler(handler)
    }
}






private var actionKey: Void?

public extension UIBarButtonItem {
    // https://stackoverflow.com/a/36983811/9506784
    private var _action: () -> Void {
        get {
            return objc_getAssociatedObject(self, &actionKey) as? () -> Void ?? { }
        }
        set {
            objc_setAssociatedObject(self, &actionKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    convenience init(title: String?, style: UIBarButtonItem.Style, action: @escaping () -> Void) {
        self.init(title: title, style: style, target: nil, action: #selector(pressed))
        self.target = self
        self._action = action
    }

    convenience init(image: UIImage?, style: UIBarButtonItem.Style, action: @escaping () -> Void) {
        self.init(image: image, style: style, target: nil, action: #selector(pressed))
        self.target = self
        self._action = action
    }

    @objc private func pressed(sender: UIBarButtonItem) {
        _action()
    }
}
