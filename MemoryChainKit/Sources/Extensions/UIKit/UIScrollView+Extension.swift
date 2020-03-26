//
//  UIScrollView+Extension.swift
//  MemoryChain
//
//  Created by Marc Zhao on 2018/8/5.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

#if canImport(UIKit)
import UIKit

#if !os(watchOS)

// MARK: - Methods
public extension UIScrollView {
    //Original Source: https://gist.github.com/thestoics/1204051
    ///  Takes a snapshot of an entire ScrollView
    ///
    ///    AnySubclassOfUIScroolView().snapshot
    ///    UITableView().snapshot
    ///
    /// - Returns: Snapshot as UIimage for rendered ScrollView
    var snapshot: UIImage? {
        UIGraphicsBeginImageContextWithOptions(contentSize, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        let previousFrame = frame
        frame = CGRect(origin: frame.origin, size: contentSize)
        layer.render(in: context)
        frame = previousFrame
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

#endif

#endif
extension UIScrollView {
    func scrollOnTop(animated:Bool = true ) {
        if #available(iOS 11.0, *) {
            setContentOffset(CGPoint(x: 0, y: -adjustedContentInset.top), animated: animated)
        } else {
            setContentOffset(CGPoint(x: 0, y: -contentInset.top), animated: animated)
        }
    }
}
public extension UIScrollView {
    func scrollToBottom(_ animated:Bool)  {
        if self.contentSize.height < self.bounds.height {
            return
        }
        let bottomOffset = CGPoint(x: 0, y: self.contentSize.height - self.bounds.height)
        
        self.setContentOffset(bottomOffset, animated: animated)
    }
}
public extension UIScrollView {
    func stopScrolling() {
        guard isDragging else {
            return
        }
        var offset = contentOffset
        offset.y -= 1
        self.setContentOffset(offset, animated: false)
        offset.y += 1
        self.setContentOffset(offset, animated: false)
    }
}
extension UIScrollView {
    public enum ScrollingDirection {
        case none
        case up
        case down
        case left
        case right
        case unknown

        public var isVertical: Bool {
            self == .up || self == .down
        }

        public var isHorizontal: Bool {
            self == .left || self == .right
        }
    }

    /// The current scrolling direction of the scroll view.
    public var currentScrollingDirection: ScrollingDirection {
        let translation = panGestureRecognizer.translation(in: superview)

        if translation.y > 0 {
            return .down
        } else if !(translation.y > 0) {
            return .up
        }

        if translation.x > 0 {
            return .right
        } else if !(translation.x > 0) {
            return .left
        }

        return .unknown
    }

    public var isScrolling: Bool {
        switch currentScrollingDirection {
            case .up, .down, .left, .right:
                return true
            case .none, .unknown:
                return false
        }
    }
}

extension UIScrollView {
    open func scrollToTop(animated: Bool) {
        setContentOffset(CGPoint(x: 0, y: -adjustedContentInset.top), animated: animated)
    }
}


extension UIScrollView {
    private final class ContentSizeResolverView:UIView {}
    /** A method to resolve scroll view content size for the given axis*/
    func resolve(axis:NSLayoutContraints.Axis,fixedView:UIView ) {
        let contentSizeResolverView = ContentSizeResolverView()
        contentSizeResolverView.isHidden = true
        addSubview(contentSizeResolverView)
    
    switch axis {
    case .isVertical:
    contentSizeResolverView.anchor.make {
    $0.horizontally.equalToSuperview()
    $0.top.equalTo(self)
    $0.height.equalTo(CGFloat(1))
    // Now the important part
    //
    // Setting the resolver view width to `fixedView` width correctly defines the
    // content width of the scroll view.
    $0.width.equalTo(fixedView)
    }
    case .isHorizontal:
    contentSizeResolverView.anchor.make {
    $0.vertically.equalToSuperview()
    $0.leading.equalTo(self)
    $0.width.equalTo(CGFloat(1))
    // Now the important part
    //
    // Setting the resolver view height to `fixedView` width correctly defines the
    // content height of the scroll view.
    $0.height.equalTo(fixedView)

    }
    @unknown default:
    fatalError(because:.unknowCaseDetected(axis))
    }
}
}
