//
//  PHAssetExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2023/10/18.
//  Copyright © 2023 Marc Steven(https://marcsteven.top). All rights reserved.
//

import Foundation
import Photos
import UIKit

public extension PHAsset {
    //https://stackoverflow.com/questions/32687403/phasset-get-original-file-name
    
    var primaryResource:PHAssetResource? {
        let types:Set<PHAssetResourceType>
        switch mediaType {
        case .video:
            types = [.video,.fullSizeVideo]
        case .image:
            types = [.photo,.fullSizePhoto]
        case .audio:
            types = [.audio]
        case .unknown:
            types = []
            
        @unknown default:
            types = []
            
            
        }
        let resources = PHAssetResource.assetResources(for: self)
        let resource = resources.first {
            types.contains($0.type)
        }
        return resource ?? resources.first
    }
    var originalFileName:String {
        guard let result = primaryResource else {
            return "file"
        }
        return result.originalFilename
    }
}
