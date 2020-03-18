//
//  UIBarButtonItemExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/18.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
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
