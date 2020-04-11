//
//  ObservableTypeExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/11.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa



extension ObservableType {
    public func  ignoreAll() ->Observable<Void> {
        return map {_ in }
    }
    public func  unwrap<T>() ->Observable<T> where Element == T? {
        return compactMap({$0})
    }
    public func execute(_ selector:@escaping (Element)->Void) ->Observable<Element> {
        return flatMap{result in
            return Observable
            .just(selector(result))
                .map {_ in result}
            .take(1)
        }
    }
    public func count()->Observable<(Element,Int)> {
        var numberOfTimeCalled = 0
        let result = map{_ ->Int in
            numberOfTimeCalled += 1
            return numberOfTimeCalled
        }
        return Observable.combineLatest(self,result)
    }
    public func merge(with other:Observable<Element>) ->Observable<Element> {
        return Observable.merge(self.asObservable(),other)
    }
    public func orEmpty() ->Observable<Element> {
        return catchError{ _ in
            return .empty()
        }
    }
    public func map<T>(to value:T) ->Observable<T> {
        return map{_ in value}
    }
    
}
extension Observable where Element == String {
    public func mapToURL() ->Observable<URL> {
        return map {URL(string: $0)}.compactMap{$0}
    }
}

