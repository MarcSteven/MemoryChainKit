//
//  UIImageView+Extensions.swift
//  MemoryChain
//
//  Created by Marc Zhao on 2018/8/4.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//


#if canImport(UIKit)
import UIKit
#if !os(watchOS)
//MARK: - method
public extension UIImageView {
    convenience init?(named name:String,
                      top:CGFloat,
                      left:CGFloat,
                      bottom:CGFloat,
                      right:CGFloat) {
        guard let image = UIImage(named: name) else {
            return nil
        }
        let insets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        let insetImage = image.withAlignmentRectInsets(insets)
        self.init(image: insetImage)
    }
    func download(
        from url:URL,
        contentMode:UIView.ContentMode = .scaleAspectFit,
        placeholder:UIImage? = nil,
        completionHandler:((UIImage?)->Void)? = nil
        ) {
        image = placeholder
        self.contentMode = contentMode
        URLSession.shared.dataTask(with: url) { (data, response, _) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data,
                let image = UIImage(data: data)
                else {
                    completionHandler?(nil)
                    return
            }
            DispatchQueue.main.async {
                self.image = image
                completionHandler?(image)
            }
            }.resume()
    }
    func blur(withStyle style: UIBlurEffect.Style = .light) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        addSubview(blurEffectView)
        clipsToBounds = true
    }
    
    ///  Blurred version of an image view
    ///
    /// - Parameter style: UIBlurEffectStyle (default is .light).
    /// - Returns: blurred version of self.
    func blurred(withStyle style: UIBlurEffect.Style = .light) -> UIImageView {
        let imgView = self
        imgView.blur(withStyle: style)
        return imgView
    }
}
#endif

public extension UIImageView{
    func getPixelColorAt(point :CGPoint) ->UIColor {
        let pixel = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: 4)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitMapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: pixel, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: bitMapInfo.rawValue)
        context!.translateBy(x: -point.x, y: -point.y)
        layer.render(in: context!)
        let color = UIColor(red: CGFloat(pixel[0]) / 255.0, green: CGFloat(pixel[1]) / 255.0, blue: CGFloat(pixel[2]) / 255.0, alpha: CGFloat(pixel[3]) / 255.0)
        pixel.deallocate()
        return color
    }
}
#endif


