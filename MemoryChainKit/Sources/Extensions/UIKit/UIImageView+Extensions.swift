//
//  UIImageView+Extensions.swift
//  MemoryChain
//
//  Created by Marc Zhao on 2018/8/4.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//


#if canImport(UIKit)
import UIKit
import ObjectiveC
#if !os(watchOS)



extension UIImageView {
    private struct AssociatedKey {
        static var isContentModeAutomaticallyAdjusted = "isContentModeAutomaticallyAdjusted"
    }
    open var isContentModeAutomaticallyAdjusted:Bool {
        get {
            (objc_getAssociatedObject(self, &AssociatedKey.isContentModeAutomaticallyAdjusted) != nil)
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.isContentModeAutomaticallyAdjusted, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
extension UIImageView {
    private func adjustContentModeIfNeeded() {
        guard isContentModeAutomaticallyAdjusted, let image = image else {
            return
        }
        if image.size.width > bounds.size.width || image.size.height > bounds.size.height {
            contentMode = .scaleAspectFit
        }else {
            contentMode = .center
        }
    }
}
extension UIImageView {
    @objc private func swizzled_setHighlightedImage(_ image:UIImage?) {
        swizzled_setHighlightedImage(image)
        if isHighlighted {
            isHighlighted = false
            isHighlighted = true
        }
        
    }
}
extension UIImageView {
    @objc private func swizzle_layoutSubviews() {
        swizzle_layoutSubviews()
        adjustContentModeIfNeeded()
    }
    @objc private func swizzle_setImage(_ image:UIImage?) {
        swizzle_setImage(image)
        adjustContentModeIfNeeded()
    }
    @objc private func swizzled_setBounds(_ bounds:CGRect) {
        swizzled_setBounds(bounds)
        adjustContentModeIfNeeded()
    }
    static func runOnceSwapSelector() {
        swizzle(UIImageView.self, originalSelector: #selector(setter: UIImageView.bounds), swizzledSelector: #selector(UIImageView.swizzled_setBounds(_:)))
        swizzle(UIImageView.self, originalSelector: #selector(setter: UIImageView.image), swizzledSelector: #selector(UIImageView.swizzle_setImage(_:)))
        swizzle(UIImageView.self, originalSelector: #selector(UIImageView.layoutSubviews), swizzledSelector: #selector(UIImageView.swizzle_layoutSubviews))
        swizzle(UIImageView.self, originalSelector: #selector(setter: UIImageView.isHighlighted), swizzledSelector: #selector(UIImageView.swizzled_setHighlightedImage(_:)))
        
    }
}
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


