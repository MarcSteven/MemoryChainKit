//
//  ValidRules.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/5.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation



public struct ValidationRule<Input> {
    private let block: (Input) -> Bool

    public init(_ block: @escaping (Input) -> Bool) {
        self.block = block
    }

    /// Returns a boolean value indicating whether the given `input` matches the
    /// conditions specified by `self`.
    ///
    /// ```swift
    /// email.validate("help@example.com") // valid
    /// email.validate("help.example.com") // invalid
    /// ```
    ///
    /// - Parameter input: The input against which to evaluate `self`.
    /// - Returns: `true` if given `input` matches the conditions specified by `self`,
    ///            otherwise `false`.
    public func validate(_ input: Input) -> Bool {
        block(input)
    }
}

// MARK: - Conditional Conformance

extension ValidationRule where Input == String {
    public init(pattern: String, transform: ((Input) -> Input)? = nil) {
        self.init { input in
            let input = transform?(input) ?? input
            return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: input)
        }
    }
}

extension ValidationRule: ExpressibleByStringLiteral where Input == String {
    public init(stringLiteral value: StringLiteralType) {
        self.init(pattern: value)
    }
}

extension ValidationRule: ExpressibleByExtendedGraphemeClusterLiteral where Input == String {
    public init(extendedGraphemeClusterLiteral value: String) {
        self.init(pattern: value)
    }
}

extension ValidationRule: ExpressibleByUnicodeScalarLiteral where Input == String {
    public init(unicodeScalarLiteral value: String) {
        self.init(pattern: value)
    }
}




