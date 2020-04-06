//
//  UIView+Rx.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/6.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import RxSwift
import RxCocoa
import UIKit

extension Reactive where Base:UIView {
    public var isHidden:Binder<Bool> {
        return Binder(base) {view,isHidden in
            view.isHidden = isHidden
        }
    }
}
