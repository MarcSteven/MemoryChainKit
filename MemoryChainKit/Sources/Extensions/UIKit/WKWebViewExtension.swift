//
//  WKWebViewExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/10/09.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//


import UIKit
import WebKit

public extension WKWebView {
    /// Navigates to the first item in the back-forward list.
    /// A new navigation to the requested item, or nil if there is no back
    /// item in the back-forward list.
    @discardableResult
     func goToFirstItem() -> WKNavigation? {
        guard let firstItem = backForwardList.backList.at(0) else {
            return nil
        }

        return go(to: firstItem)
    }

    /// Navigates to the last item in the back-forward list.
    /// A new navigation to the requested item, or nil if there is no back
    /// item in the back-forward list.
    @discardableResult
     func goToLastItem() -> WKNavigation? {
        let forwardList = backForwardList.forwardList

        guard let lastItem = forwardList.at(forwardList.count - 1) else {
            return nil
        }

        return go(to: lastItem)
    }
}
