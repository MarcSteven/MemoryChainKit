//
//  FormDataType.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/16.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation

/// The type of the form data .
///
/// - data: Plain data, it uses "application/octet-stream" as the Content-Type.
/// - png: PNG image, it uses "image/png" as the Content-Type.
/// - jpg: JPG image, it uses "image/jpeg" as the Content-Type.
/// - custom: Sends your parameters as plain data, sets your `Content-Type` to the value inside `custom`.
public enum FormDataType {
    case data
    case png
    case jpg
    case custom(String)

    var contentType: String {
        switch self {
        case .data:
            return "application/octet-stream"
        case .png:
            return "image/png"
        case .jpg:
            return "image/jpeg"
        case let .custom(value):
            return value
        }
    }
}
