//
//  UIBarButtonItem+Rx.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/6.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

extension Reactive where Base:UIBarButtonItem {
    public var image:Binder<UIImage> {
        return Binder(base) {button,image in
            button.image = image
        }
    }
}
