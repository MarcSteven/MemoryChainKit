//
//  FatalReason.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/18.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation

// See: https://github.com/apple/swift-evolution/pull/861/files

/// Reasons why code should abort at runtime
public struct FatalReason: CustomStringConvertible {
    /// An underlying string-based cause for a fatal error.
    public let reason: String

    /// Establishes a new instance of a `FatalReason` with a string-based explanation.
    public init(_ reason: String) {
        self.reason = reason
    }

    /// Conforms to CustomStringConvertible, allowing reason to print directly to complaint.
    public var description: String {
        reason
    }
}

extension FatalReason: ExpressibleByStringLiteral {
    public init(stringLiteral value: StringLiteralType) {
        self.init(value)
    }
}

extension FatalReason {
    public static let subclassMustImplement: Self = "Must be implemented by subclass."
}

// MARK: Xcore Fatal Reasons

extension FatalReason {
    static let unsupportedFallbackFormattingStyle: Self = "Fallback style shouldn't be of type `abbreviationWith`."

    static func unknownCaseDetected<T: RawRepresentable>(_ case: T) -> Self {
        .init("Unknown case detected: \(`case`) - (\(`case`.rawValue))")
    }

    static func dequeueFailed(for name: String, identifier: String) -> Self {
        .init("Failed to dequeue \(name) with identifier: \(identifier)")
    }

    static func dequeueFailed(for name: String, kind: String, indexPath: IndexPath) -> Self {
        .init("Failed to dequeue \(name) for kind: \(kind) at indexPath(\(indexPath.section), \(indexPath.item))")
    }
}

/// Unconditionally prints a given message and stops execution.
///
/// - Parameters:
///   - reason: A predefined `FatalReason`.
///   - function: The name of the calling function to print with `message`. The
///     default is the calling scope where `fatalError(because:, function:, file:, line:)`
///     is called.
///   - file: The filename to print with `message`. The default is the file
///     where `fatalError(because:, function:, file:, line:)` is called.
///   - line: The line number to print along with `message`. The default is the
///     line number where `fatalError(because:, function:, file:, line:)` is called.
@_transparent
public func fatalError(
    because reason: FatalReason,
    function: StaticString = #function,
    file: StaticString = #file,
    line: UInt = #line
) -> Never {
    fatalError("\(function): \(reason)", file: file, line: line)
}

/**Print a warning message in debug mode*/

@_transparent

public func warnUnknown(_ value:Any,
                        file:String = #file,
                        function:String = #function,
                        line:Int = #line)  {
    #if DEBUG
    Console.warn("Unknown value detected: \(value)", className: file, functionName: function, lineNumber: line)

    #endif
}
