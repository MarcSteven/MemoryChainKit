//
//  String+HMAC.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2018/10/1.
//  Copyright © 2018 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation
import CommonCrypto



public enum HMACAlogorithm {
    case md5,sha1,sha224,sha256,sha384,sha512
    func toCCHmacAlogorithm() ->CCHmacAlgorithm {
        var result:Int = 0
        switch self {
        case .md5:
            result = kCCHmacAlgMD5
        case .sha1:
            result = kCCHmacAlgSHA1
        case .sha224:
            result = kCCHmacAlgSHA224
        case .sha256:
            result = kCCHmacAlgSHA256
        case .sha384:
            result = kCCHmacAlgSHA384
        case .sha512:
            result = kCCHmacAlgSHA512
        
        }
        return CCHmacAlgorithm(result)
        
    }
    func digestLength() ->Int {
        var result:CInt = 0
        switch self {
        case .md5:
            result = CC_MD5_DIGEST_LENGTH
        case .sha1:
            result = CC_SHA1_DIGEST_LENGTH
        case .sha224:
            result = CC_SHA224_DIGEST_LENGTH
        case .sha256:
            result = CC_SHA256_DIGEST_LENGTH
        case .sha512:
            result = CC_SHA512_DIGEST_LENGTH
        case .sha384:
            result = CC_SHA384_DIGEST_LENGTH
        
        }
        return Int(result)
    }
}

