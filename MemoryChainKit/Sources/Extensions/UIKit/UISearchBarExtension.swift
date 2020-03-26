//
//  UISearchBarExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/26.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//



import UIKit

extension UISearchBar {
    open var textField: UITextField? {
        firstSubview(withClass: UITextField.self)
    }

    @objc dynamic open var searchFieldBackgroundColor: UIColor? {
        get {
            switch searchBarStyle {
                case .minimal:
                    return textField?.layer.backgroundColor?.uiColor
                default:
                    return textField?.backgroundColor
            }
        }
        set {
            guard let newValue = newValue else { return }

            switch searchBarStyle {
                case .minimal:
                    textField?.layer.backgroundColor = newValue.cgColor
                    textField?.clipsToBounds = true
                    textField?.layer.cornerRadius = 8
                default:
                    textField?.backgroundColor = newValue
            }
        }
    }
}

extension UISearchBar {
    private struct AssociatedKey {
        static var placeholderTextColor = "placeholderTextColor"
        static var initialPlaceholderText = "initialPlaceholderText"
        static var didSetInitialPlaceholderText = "didSetInitialPlaceholderText"
    }

    /// The default value is `nil`. Uses `UISearchBar` default gray color.
    @objc dynamic open var placeholderTextColor: UIColor? {
        /// Unfortunately, when the `searchBarStyle == .minimal` then
        /// `textField?.placeholderLabel?.textColor` doesn't work. Hence, this workaround.
        get { associatedObject(&AssociatedKey.placeholderTextColor) }
        set {
            setAssociatedObject(&AssociatedKey.placeholderTextColor, value: newValue)

            // Redraw placeholder text on color change
            let placeholderText = placeholder
            placeholder = placeholderText
        }
    }

    private var didSetInitialPlaceholderText: Bool {
        get { associatedObject(&AssociatedKey.didSetInitialPlaceholderText, default: false) }
        set { setAssociatedObject(&AssociatedKey.didSetInitialPlaceholderText, value: newValue) }
    }

    private var initialPlaceholderText: String? {
        get { associatedObject(&AssociatedKey.initialPlaceholderText) }
        set { setAssociatedObject(&AssociatedKey.initialPlaceholderText, value: newValue) }
    }

    @objc private var swizzled_placeholder: String? {
        get { textField?.attributedPlaceholder?.string }
        set {
            if superview == nil, let newValue = newValue {
                initialPlaceholderText = newValue
                return
            }

            guard let textField = textField else {
                return
            }

            guard let newValue = newValue else {
                textField.attributedPlaceholder = nil
                return
            }

            if let placeholderTextColor = placeholderTextColor {
                textField.attributedPlaceholder = NSAttributedString(string: newValue, attributes: [
                    .foregroundColor: placeholderTextColor
                ])
            } else {
                textField.attributedPlaceholder = NSAttributedString(string: newValue)
            }
        }
    }

    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard superview != nil, !didSetInitialPlaceholderText else { return }

        if let placeholderText = initialPlaceholderText {
            placeholder = placeholderText
            initialPlaceholderText = nil
        }

        didSetInitialPlaceholderText = true
    }
}

// MARK: Swizzle

extension UISearchBar {
    static func runOnceSwapSelectors() {
        swizzle(
            UISearchBar.self,
            originalSelector: #selector(getter: UISearchBar.placeholder),
            swizzledSelector: #selector(getter: UISearchBar.swizzled_placeholder)
        )

        swizzle(
            UISearchBar.self,
            originalSelector: #selector(setter: UISearchBar.placeholder),
            swizzledSelector: #selector(setter: UISearchBar.swizzled_placeholder)
        )
    }
}
