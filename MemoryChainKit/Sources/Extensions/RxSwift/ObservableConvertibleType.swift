//
//  ObservableConvertibleType.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/6.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension ObservableConvertibleType {
    public func asDriverJustShowErrorMessage() ->Driver<Element> {
        return self.asObservable()
        .asDriver(onErrorRecover: {(error) ->Driver<Element> in
            #warning("TODO - add hud")
            return Driver.empty()
        })
    }
}
