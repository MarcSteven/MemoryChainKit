//
//  CGContextExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/18.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import UIKit
import CoreGraphics

extension CGContext {
    /// This method scales the image (disproportionately, if necessary) to fit the bounds
    /// specified by the rect parameter. When the `byTiling` parameter is true, the image is
    /// tiled in user space—thus, unlike when drawing with patterns, the current
    /// transformation (see the `ctm` property) affects the final result.
    ///
    /// - Parameters:
    ///   - image: The image to draw.
    ///   - rect: The rectangle, in user space coordinates, in which to draw the image.
    ///   - byTiling:
    ///     If `true`, this method fills the context's entire clipping region by tiling
    ///     many copies of the image, and the `rect` parameter defines the origin and
    ///     size of the tiling pattern.
    ///
    ///     If `false` (the default), this method draws a single copy of the image in the
    ///     area defined by the `rect` parameter.
    public func draw(_ image: UIImage, in rect: CGRect, byTiling: Bool = false) {
        draw(image.cgImage!, in: rect, byTiling: byTiling)
    }
}

