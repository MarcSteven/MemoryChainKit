//
//  FailureJSONResponse.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/16.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation
public class SucessfulJSONResponse:JSONResponse {}
public class FailureJSONResponse:JSONResponse {
    public let error:NSError
    init(json:JSONType,
         response:HTTPURLResponse,
         error:NSError) {
        self.error = error
        super.init(json: json, response: response)
    }
}
