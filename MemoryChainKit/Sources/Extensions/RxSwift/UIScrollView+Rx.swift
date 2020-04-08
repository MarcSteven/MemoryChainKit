//
//  UIScrollView+Rx.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/6.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

public extension Reactive where Base:UIScrollView {
    func reachedBottom(offset:CGFloat = 500)->ControlEvent<Bool> {
        let source = contentOffset.map {contentOffset ->Bool in
            let visibleHeight = self.base.frame.height - self.base.contentInset.top - self.base.contentInset.bottom
            let y = contentOffset.y + self.base.contentInset.top + self.base.contentInset.bottom
            let threshold = max(offset, self.base.contentSize.height - visibleHeight - offset)
            return y > threshold
            
        }
    .distinctUntilChanged()
        return ControlEvent(events: source)
    }
}
    