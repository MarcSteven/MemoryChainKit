//
//  GiftImage.swift
//  MemoryChainUIKit
//
//  Created by Marc Zhao on 2018/9/12.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit
import ImageIO

open class GiftImage {
    public class func imageWithName(name:String) ->UIImage? {
        return UIImage(named: name)
    }
    public class func loadImageWithUrl(url:URL) ->UIImage? {
        guard let imageData = try? Data(contentsOf: url) else {
            return nil
        }
        let image = GiftImage.loadGiftData(data: imageData)
        return image
    }
    public class func imageWithData(data:Data) ->UIImage? {
        guard let imageSource = CGImageSourceCreateWithData(data as CFData, nil) else {
            return nil
        }
        let totalCount = CGImageSourceGetCount(imageSource)
        var image:UIImage?
        if totalCount == 1 {
            image = UIImage(data: data)
        }else {
            image = GiftImage.loadGiftData(data: data)
        }
        
        return image
    }
    public class func loadGiftImage(imageName:String) ->UIImage? {
        var nameString = imageName
        if nameString.contains(".gif") {
            let temp = nameString as NSString
            nameString = temp.substring(to: temp.length - 4)
            
        }
        guard let bundleURL = Bundle.main.url(forResource: nameString, withExtension: ".gif") else {
            return nil
        }
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            return nil
        }
        return loadGiftData(data: imageData)
    }
    public class func loadGiftData(data:Data) ->UIImage? {
        guard let imageSource = CGImageSourceCreateWithData(data as CFData, nil) else {
            return nil
        }
        return loadGiftImageFromSource(source: imageSource)
        
    }
    private class func loadGiftImageFromSource(source:CGImageSource) ->UIImage? {
        let totalCount = CGImageSourceGetCount(source)
        var images = [UIImage]()
        var gifDuration = 0.0
        for i in 0 ..< totalCount {
            if let cfImage = CGImageSourceCreateImageAtIndex(source, i, nil),
                let properties = CGImageSourceCopyPropertiesAtIndex(source, i, nil),
                let gifInfo = (properties as NSDictionary)[kCGImagePropertyGIFDictionary as String] as? NSDictionary,
                let frameDuration = (gifInfo[kCGImagePropertyGIFDelayTime as String] as? NSNumber) {
                gifDuration += frameDuration.doubleValue
                let image = UIImage(cgImage: cfImage)
                images.append(image)
            }
        }
        let animation = UIImage.animatedImage(with: images, duration: gifDuration)
        return animation
    }
}
