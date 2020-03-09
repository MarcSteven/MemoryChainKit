//
//  InvalidItemBehaviour.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2018/12/28.
//  Copyright © 2018 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation

/// The behaviour of what should be done when an invalid JSON object or primitive is found
///
/// - remove: The item is filtered, only valid items are returned
/// - fail:  The call fails. For non optional properties this will throw an error, and for optional properties nil is returned
public enum InvalidItemBehaviour<T> {
    case remove
    case fail
    case value(T)
    case custom((DecodingError) -> InvalidItemBehaviour<T>)
    
    func decodeItem(decode: () throws -> T) throws -> T? {
        do {
            return try decode()
        } catch {
            let decodingError = error as? DecodingError
            
            switch self {
            case .remove:
                return nil
            case .fail:
                throw error
            case .value(let value):
                return value
            case .custom(let getBehaviour):
                guard let decodingError = decodingError  else { return nil }
                let behaviour = getBehaviour(decodingError)
                return try behaviour.decodeItem(decode: decode)
            }
        }
    }
}
