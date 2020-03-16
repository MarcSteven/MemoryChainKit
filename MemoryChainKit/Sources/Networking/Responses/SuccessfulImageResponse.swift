//
//  SuccessfulImageResponse.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/16.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation

public class SuccessImageResponse: HTTPResponse {
    public let image: Image

    init(image: Image, response: HTTPURLResponse) {
        self.image = image

        super.init(response: response)
    }
}

public class SuccessDataResponse: HTTPResponse {
    public let data: Data

    init(data: Data, response: HTTPURLResponse) {
        self.data = data

        super.init(response: response)
    }
}
