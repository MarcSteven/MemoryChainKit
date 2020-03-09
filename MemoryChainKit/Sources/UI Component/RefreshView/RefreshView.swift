//
//  RefreshView.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2018/9/25.
//  Copyright © 2018 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit




private let sceneHeight: CGFloat = 180

open class RefreshView: UIView {
    
    private  var scrollView: UIScrollView
    var progressPercentage: CGFloat = 0
    var refreshItems = [RefreshItem]()
    
    required public init?(coder aDecoder: NSCoder) {
        scrollView = UIScrollView()
        super.init(coder:aDecoder)!
        
        setupRefreshItems()
        
    }
    
    func setupRefreshItems() {
        
        let groundImageView = UIImageView(image:UIImage(named: ""))
        let buildingsImageView = UIImageView(image:UIImage(named: ""))
        let sunImageView = UIImageView(image:UIImage(named: ""))
        let catImageView = UIImageView(image:UIImage(named: ""))
        let capeBackImageView = UIImageView(image:UIImage(named: ""))
        let capeFrontImageView = UIImageView(image:UIImage(named: ""))
        
        refreshItems = [
            
            RefreshItem(view: buildingsImageView, centerEnd: CGPoint(x: bounds.midX, y: bounds.height - groundImageView.bounds.height - buildingsImageView.bounds.height / 2), parallaxRatio: 1.5, sceneHeight: sceneHeight),
            RefreshItem(view: sunImageView, centerEnd: CGPoint(x: bounds.width * 0.1, y: bounds.height - groundImageView.bounds.height - sunImageView.bounds.height ), parallaxRatio: 3, sceneHeight: sceneHeight),
            RefreshItem(view: groundImageView, centerEnd: CGPoint(x: bounds.midX, y: bounds.height - groundImageView.bounds.height / 2), parallaxRatio: 0.5, sceneHeight: sceneHeight),
            RefreshItem(view: capeBackImageView, centerEnd: CGPoint(x: bounds.midX, y: bounds.height - groundImageView.bounds.height/2 - capeBackImageView.bounds.height / 2), parallaxRatio: -1, sceneHeight: sceneHeight),
            
            RefreshItem(view: catImageView, centerEnd: CGPoint(x: bounds.midX, y: bounds.height - groundImageView.bounds.height/2 - catImageView.bounds.height / 2), parallaxRatio: 1, sceneHeight: sceneHeight),
            RefreshItem(view: capeFrontImageView, centerEnd: CGPoint(x: bounds.midX, y: bounds.height - groundImageView.bounds.height / 2 - capeFrontImageView.bounds.height / 2), parallaxRatio: -1, sceneHeight: sceneHeight)
        ]
        
        for refreshItem in refreshItems {
            addSubview(refreshItem.view)
        }
        
        
    }
    
    func updateRefreshItemPositions() {
        for refreshItem in refreshItems {
            refreshItem.updateViewPositionForPercentage(progressPercentage)
        }
    }
    
    
    init(frame: CGRect, scrollView: UIScrollView) {
        self.scrollView = scrollView
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.green
        setupRefreshItems()
    }
    
    func updateBackgroundColor() {
        let value = progressPercentage * 0.7 + 0.2
        backgroundColor = UIColor(red:value, green:value, blue:value, alpha:1.0)
    }
    
}



extension RefreshView: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let refreshViewVisibleHeight = max(0, -(scrollView.contentOffset.y + scrollView.contentInset.top))
        progressPercentage = min(1, refreshViewVisibleHeight / sceneHeight)
        print("progress percetntage: \(progressPercentage)")
        updateBackgroundColor()
        updateRefreshItemPositions()
    }
}
