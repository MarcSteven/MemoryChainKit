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
