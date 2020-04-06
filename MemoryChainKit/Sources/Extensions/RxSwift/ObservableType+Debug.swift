//
//  ObservableType+Debug.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/6.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension ObservableType {
    public func debug(_ identifier:String) ->Observable<Self.Element> {
        return Observable.create({observer in
            print("subscribed \(identifier)")
            let subscription = self.subscribe() {e in
                print("event\(identifier) \(e)")
                switch e {
                case .next(let value):
                    observer.onNext(value)
                case .error(let error):
                    observer.onError(error)
                case .completed:
                    observer.onCompleted()
                    
                }
            }
            return Disposables.create {
                print("disposing \(identifier)")
                subscription.dispose()
            }
        })
    }
}
