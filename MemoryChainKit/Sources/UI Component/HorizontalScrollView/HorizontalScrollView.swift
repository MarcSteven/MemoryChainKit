//
//  HorizontalScrollView.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/2/12.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation



public protocol HorizontalScrollViewDataSource:class {
    func numberOfViews( in horizontalScrollView:HorizontalScrollView) ->Int
    func horizontalScrollView(_ horizontalScrollView:HorizontalScrollView, viewAt index:Int) ->UIView
}
public protocol HorizontalScrollViewDelegate:class {
    func horizontalScrollerView(_ horizontalScrollerView:HorizontalScrollView,didSelectViewAt index:Int)
}
open class HorizontalScrollView:UIView {
    weak var dataSource:HorizontalScrollViewDataSource?
    weak var delegate:HorizontalScrollViewDelegate?
    //
    private enum ViewConstants {
        static let padding:CGFloat = 10
        static let dimensions:CGFloat = 100
        static let offset :CGFloat = 100
    }
    private let scroller = UIScrollView()
    private var contentViews = [UIView]()
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func initializeScrollView() {
        scroller.delegate = self
        addSubview(scroller)
        scroller.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scroller.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scroller.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scroller.topAnchor.constraint(equalTo: self.topAnchor),
            scroller.bottomAnchor.constraint(equalTo: self.bottomAnchor)
                                     ])
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(scrollerTapped(gesture:)))
        scroller.addGestureRecognizer(tapGestureRecognizer)
    }
    @objc func scrollerTapped(gesture:UITapGestureRecognizer) {
        let location = gesture.location(in: scroller)
        guard let index = contentViews.firstIndex(where:{$0.frame.contains(location)}) else {
            return
        }
        delegate?.horizontalScrollerView(self, didSelectViewAt: index)
    }
    func view(at index:Int) ->UIView {
        return contentViews[index]
    }
    func reload() {
        guard let dataSource = dataSource else {
            return
        }
        contentViews.forEach{ $0.removeFromSuperview()}
        var xValue = ViewConstants.offset
        contentViews = (0..<dataSource.numberOfViews(in: self)).map {
            index in
            xValue += ViewConstants.padding
            let view = dataSource.horizontalScrollView(self, viewAt: index)
            view.frame = CGRect(x: CGFloat(xValue), y: ViewConstants.padding, width: ViewConstants.dimensions, height: ViewConstants.dimensions)
            scroller.addSubview(view)
            xValue += ViewConstants.dimensions + ViewConstants.padding
            return view
        }
        scroller.contentSize = CGSize(width: CGFloat(xValue + ViewConstants.offset), height: frame.size.height)
        
    }
    private func centerCurrentView() {
        let centerRect = CGRect(origin: CGPoint(x: scroller.bounds.midX - ViewConstants.padding, y: 0), size: CGSize(width: ViewConstants.padding, height: bounds.height))
        guard let selectedIndex = contentViews.firstIndex(where:{$0.frame.intersects(centerRect)}) else {
            return
        }
        let centralView = contentViews[selectedIndex]
        let targetCenter = centralView.center
        let targetOffsetX = targetCenter.x - (scroller.bounds.width / 2)
        scroller.setContentOffset(CGPoint(x: targetOffsetX, y: 0), animated: true)
        delegate?.horizontalScrollerView(self, didSelectViewAt: selectedIndex)
        
    }
    
    
}
extension HorizontalScrollView:UIScrollViewDelegate {
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            centerCurrentView()
        }
    }
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        centerCurrentView()
    }
}
