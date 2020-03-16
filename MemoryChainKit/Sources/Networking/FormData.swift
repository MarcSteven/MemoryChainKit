//
//  FormData.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/16.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation

/// The form data .
public struct FormData {
    fileprivate let data: Data
    fileprivate let parameterName: String
    fileprivate let filename: String?
    fileprivate let type: FormDataType
    var boundary: String = ""

    var formData: Data {
        var body = ""
        body += "--\(boundary)\r\n"
        body += "Content-Disposition: form-data; "
        body += "name=\"\(parameterName)\""
        if let filename = filename {
            body += "; filename=\"\(filename)\""
        }
        body += "\r\n"
        body += "Content-Type: \(type.contentType)\r\n\r\n"

        var bodyData = Data()
        bodyData.append(body.data(using: .utf8)!)
        bodyData.append(data)
        bodyData.append("\r\n".data(using: .utf8)!)

        return bodyData as Data
    }

    public init(type: FormDataType = .data, data: Data, parameterName: String, filename: String? = nil) {
        self.type = type
        self.data = data
        self.parameterName = parameterName
        self.filename = filename
    }
}
