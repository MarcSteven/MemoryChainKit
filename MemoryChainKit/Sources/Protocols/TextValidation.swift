//
//  TextValidation.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/1/23.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation



public protocol  TextValidation {
    var regExFindMatchingString:String { get }
    var validationMessage:String { get }
}
extension TextValidation {
    var regExFindMatchingString:String {
        get {
            return regExFindMatchingString + "$"
        }
    }
        func validateString(str:String) ->Bool {
        if let _ = str.range(of: regExFindMatchingString, options: .regularExpression) {
            return true
        }else {
            return  false
        }
    }
    func getMatchingString(str:String) ->String? {
        if let newMatch = str.range(of: regExFindMatchingString, options: .regularExpression) {
            return String(str[newMatch])
        }else {
            return nil
        }
    }
}
