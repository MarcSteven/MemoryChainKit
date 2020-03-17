//
//  URL+PrintFileSize.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/6/5.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation
import MobileCoreServices


//Utility to print file size to console

public extension URL {
    func mimeType() -> String {
            let pathExtension = self.pathExtension
            if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension as NSString, nil)?.takeRetainedValue() {
                if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
                    return mimetype as String
                }
            }
            return "application/octet-stream"
        }
        var containsImage: Bool {
            let mimeType = self.mimeType()
            guard let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, mimeType as CFString, nil)?.takeRetainedValue() else {
                return false
            }
            return UTTypeConformsTo(uti, kUTTypeImage)
        }
        var containsAudio: Bool {
            let mimeType = self.mimeType()
            guard let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, mimeType as CFString, nil)?.takeRetainedValue() else {
                return false
            }
            return UTTypeConformsTo(uti, kUTTypeAudio)
        }
        var containsVideo: Bool {
            let mimeType = self.mimeType()
            guard  let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, mimeType as CFString, nil)?.takeRetainedValue() else {
                return false
            }
            return UTTypeConformsTo(uti, kUTTypeMovie)
        }

    //Get current mime type of url w.r.t its url
        var currentMimeType: String {

            if self.containsImage{
                return "image/png"
            }else if self.containsAudio{
                return "audio/mp3"
            }else if self.containsVideo{
                return "video/mp4"
            }

            return ""
        }
    }

    
    

