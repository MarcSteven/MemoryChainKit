//
//  UIAlertController+Rx.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/6.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base:UIAlertController {
    public var title:Binder<String> {
        return Binder(base) {
            alertController,title in
            alertController.title  = title
        }
    }
    public var message:Binder<String> {
        return Binder(base) {alertViewController,message in
            alertViewController.message = message
        }
    }
}
