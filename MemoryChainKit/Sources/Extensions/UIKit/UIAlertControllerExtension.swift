//
//  UIAlertExtension.swift
//  MemoryChainKit
//
//  Created by Papi on 2019/6/28.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//
import UIKit

public extension UIAlertController {
    //在指定视图控制器上弹出普通消息提示框
    static func showAlert(message: String, in viewController: UIViewController) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "continue".localized, style: .cancel))
        viewController.present(alert, animated: true)
    }
    
    //在根视图控制器上弹出普通消息提示框
    static func showAlert(message: String) {
        if let vc = UIApplication.shared.keyWindow?.rootViewController {
            showAlert(message: message, in: vc)
        }
    }
    
    //在指定视图控制器上弹出确认框
    static func showConfirm(title: String, message: String, in viewController: UIViewController,
                            confirm: ((UIAlertAction)->Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "cancel".localized, style: .cancel))
        alert.addAction(UIAlertAction(title: "continue".localized, style: .default, handler: confirm))
        viewController.present(alert, animated: true)
    }
    
    //在根视图控制器上弹出确认框
    static func showConfirm(title: String, message: String, confirm: ((UIAlertAction)->Void)?) {
        if let vc = UIApplication.shared.keyWindow?.rootViewController {
            showConfirm(title: title, message: message, in: vc, confirm: confirm)
        }
    }
    
    // 提示框弹出后，过段时间自动移除
    static func showAlertDismiss(message: String, in viewController: UIViewController, after: Double) {
        let alertController = UIAlertController(title: nil,
                                                message: message, preferredStyle: .alert)
        //显示提示框
        viewController.present(alertController, animated: true, completion: nil)
        //两秒钟后自动消失
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + after) {
            viewController.presentedViewController?.dismiss(animated: false, completion: nil)
        }
    }
}
public extension UIAlertController {
    func setBackgroundColorForAlertController(_ color:UIColor) {
        if let backgroundView = self.view.subviews.first,
        let groupView = backgroundView.subviews.first,
            let contentView = groupView.subviews.first {
            contentView.backgroundColor = color
        }
    }
    func setTitleFontAndColorForAlertController(_ font:UIFont?,
                                                color:UIColor?) {
        guard let title = self.title else {
            return
        }
        let attributeString = NSMutableAttributedString(string: title)
        if let titleFont = font {
            attributeString.addAttributes([NSAttributedString.Key.font:titleFont], range: NSMakeRange(0, title.utf8.count))
        }
        if let titleColor = color {
            attributeString.addAttributes([NSAttributedString.Key.foregroundColor:titleColor], range: NSMakeRange(0, title.utf8.count))
        }
        self.setValue(attributeString, forKey: "attributedTitle")
    }
    // set message font and message color
    func setMessageFontAndColorForAlertController(_ font:UIFont?,
                                                  color:UIColor?) {
        guard let title = self.message else {
            return
        }
        let attributedString = NSMutableAttributedString(string: title)
        if let titleFont = font {
            attributedString.addAttributes([NSAttributedString.Key.font:titleFont], range: NSMakeRange(0, title.utf8.count))
        }
        if let titleColor = color {
            attributedString.addAttributes([NSAttributedString.Key.foregroundColor:titleColor], range: NSMakeRange(0, title.utf8.count))
        }
        self.setValue(attributedString, forKey: "attributedMessage")
    }
    // set tintColor for AlertController
    func setTintColorForAlertController(_ color:UIColor) {
        self.view.tintColor = color
    }
}


extension UIAlertController {
    public var alertWindow:UIWindow? {
        get {
            return objc_getAssociatedObject(self, "alertWindow") as? UIWindow
        }
        set(window) {
            objc_setAssociatedObject(self, "alertWindow", window, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    public func show() {
        show(true, completionHandler: nil)
    }
    public func show(_ animated:Bool) {
        show(animated, completionHandler: nil)
    }
    public func show(_ animated:Bool,
                     completionHandler:(()->Void)?) {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.alertWindow = window
        window.rootViewController = UIViewController()
        window.windowLevel =  UIWindow.Level.alert + 1
        DispatchQueue.main.async {
            window.makeKeyAndVisible()
            window.rootViewController!.present(self, animated: animated, completion: completionHandler)
        }
    }
    
}
public protocol PopOverPresentationSourceView {}

extension UIView:PopOverPresentationSourceView {}
extension UIBarButtonItem:PopOverPresentationSourceView {}
extension UIPopoverPresentationController {
    public func setSourceView(_ sourceView:PopOverPresentationSourceView) {
        //For iPad support
        if let sourceView = sourceView as? UIView {
            self.sourceView = sourceView
            self.sourceRect = sourceView.bounds
        }else if let sourceView = sourceView as? UIBarButtonItem {
            self.barButtonItem = sourceView
        }
    }
}
extension UIAlertController {
    open func show(presentingViewController:UIViewController? = nil) {
        guard let presentingViewController = presentingViewController ?? UIApplication.sharedOrNil?.keyWindow?.topViewController() else {
            return
        }
        DispatchQueue.main.async {
            [weak presentingViewController] in
            presentingViewController?.present(self, animated: true, completion: nil)
        }
    }
}
extension UIAlertController {
    /// A convenience method to present multiple actions using `UIAlertController`.
    ///
    /// - Parameters:
    ///   - actions:             A an array of `UIAlertAction` to display.
    ///   - title:               The title of the alert. Use this string to get the user’s attention and communicate the reason for the alert.
    ///   - message:             Descriptive text that provides additional details about the reason for the alert.
    ///   - sourceView:          A source view that presented the alert. A required property for iPad support.
    ///   - style:               The style to use when presenting the alert controller.
    ///                          Use this parameter to configure the alert controller as an action sheet or as a modal alert.
    ///                          The default value is `.actionSheet`.
    ///   - appendsCancelAction: An option to automatically append cancel action in addition to the provided array of actions.
    ///                          The default value is `true`.
    @discardableResult
    public static func present(actions: [UIAlertAction], title: String? = nil, message: String? = nil, sourceView: PopOverPresentationSourceView, style: Style = .actionSheet, appendsCancelAction: Bool = true) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)

        // For iPad support
        alertController.popoverPresentationController?.setSourceView(sourceView)

        for action in actions {
            alertController.addAction(action)
        }

        if appendsCancelAction {
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel) { [weak alertController] action in
                alertController?.dismiss(animated: true)
            })
        }

        alertController.show()
        return alertController
    }
}

extension UIAlertController {
    /// A convenience method to display an action sheet with list of specified options.
    ///
    /// **Example:**
    ///
    /// ```swift
    /// let options = ["Year", "Month", "Day"]
    /// UIAlertController.present(options: options, sourceView: button) { option in
    ///     print("selected option:" option)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - sourceView: A source view that presented the alert. A required property for iPad support.
    ///   - handler: A block to invoke when an option is selected.
    @discardableResult
    public static func present(options: [String], title: String? = nil, message: String? = nil, sourceView: PopOverPresentationSourceView, _ handler: @escaping (_ option: String) -> Void) -> UIAlertController {
        let actions = options.map { option in
            UIAlertAction(title: option, style: .default) { _ in
                handler(option)
            }
        }

        return present(actions: actions, title: title, message: message, sourceView: sourceView)
    }

}
