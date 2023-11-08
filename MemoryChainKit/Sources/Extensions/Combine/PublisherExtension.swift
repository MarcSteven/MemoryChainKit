//
//  PublisherExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2023/11/8.
//  Copyright © 2023 Marc Steven(https://marcsteven.top). All rights reserved.
//

import Foundation
import Combine


@available(iOS 13.0, *)
extension Publisher where Failure == Never {
    
    public func sink<Root>(to handler: @escaping (Root) -> (Output) -> Void, on root: Root) -> AnyCancellable where Root: AnyObject {
        sink{ [weak root] value in
            guard let root = root else { return }
            handler(root)(value)
        }
    }
    
    public func sink<Root>(to handler: @escaping (Root) -> () -> Void, on root: Root) -> AnyCancellable where Root: AnyObject {
        sink{ [weak root] _ in
            guard let root = root else { return }
            handler(root)()
        }
    }
}

@available(iOS 13.0, *)
extension Publisher {
    
    public func eraseToAnyError() -> Publishers.MapError<Self, Error> {
        mapError { $0 as Error }
    }
    
    public func `catch`(_ handler: @escaping (Failure) -> Output) -> Publishers.Catch<Self, Just<Output>> {
        `catch`{ error in Just(handler(error)) }
    }
    
    public func flatMap<P>(
        maxPublishers: Subscribers.Demand = .unlimited,
        _ transform: @escaping (Output) -> P
    ) -> Publishers.FlatMap<Publishers.MapError<P, Error>, Publishers.MapError<Self, Error>> where P: Publisher {
        eraseToAnyError().flatMap { output in
            transform(output).eraseToAnyError()
        }
    }
}

@available(iOS 13.0, *)

//https://stackoverflow.com/questions/66010221/swift-extending-combine-operators
public extension Publisher where Output == URLSession.DataTaskPublisher.Output {
  
    func processData() -> Publishers.TryMap<Self, Data> {
        tryMap { element -> Data in
            guard let httpResponse = element.response as? HTTPURLResponse,
                  httpResponse.statusCode == 200
            else {
                throw URLError(.badServerResponse)
            }
            return element.data
        }
    }
}
