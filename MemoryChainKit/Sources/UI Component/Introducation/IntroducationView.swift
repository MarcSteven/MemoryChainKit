//
//  IntroducationView.swift
//  MemoryChainUIKit
//
//  Created by Marc Zhao on 2018/9/12.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit

import  AVFoundation

//

open class IntroducationView:UIView {
    fileprivate var imageDelegate:IntroducationImageProtocol!
    fileprivate var videoDelegate:IntroducationVideoProtocol!
    fileprivate lazy var enterButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(enterButtonEvent), for: .touchUpInside)
        return button
    }()
    fileprivate var pagecControl:PageControl!
    fileprivate var imageViews = [UIImageView]()
    //MARK: - init method
    
    public convenience init?(frame:CGRect,imageNameGroup:[String],
                             imageDelegate:IntroducationImageProtocol,
                             showNewVersion:Bool = false) {
        if imageNameGroup.count == 0 {return nil}
        self.init(frame: frame, showNewVersion: showNewVersion)
        
        self.imageDelegate = imageDelegate
        let width = frame.size.width
        let height = frame.size.height
        
        let scrollView = UIScrollView(frame: frame)
        
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.delegate = self as UIScrollViewDelegate
        scrollView.contentSize = CGSize(width: width*CGFloat(imageNameGroup.count), height: height)
        addSubview(scrollView)
        for i in 0..<imageNameGroup.count {
            let imgViewFrame = CGRect(x: CGFloat(i)*width, y: 0, width: width, height: height)
            let imageView = UIImageView(frame: imgViewFrame)
            imageView.isUserInteractionEnabled = true
            scrollView.addSubview(imageView)
            let imageName = imageNameGroup[i]
            if imageName.contains(".gif") {
                imageView.image = GiftImage.loadGiftImage(imageName: imageName)
            } else {
                imageView.image = GiftImage.loadGiftImage(imageName: imageName)
                   
            }
            imageViews.append(imageView)
        }
        setupPageControl(imageNameGroup.count)
           imageDelegate.introducationPageCustomizedPageControl(pagecControl)
        let position = imageDelegate.introducationPageCustomizedEnterButton(enterButton)
        switch position {
        case .always:
            addSubview(enterButton)
        default:
            let imageView = imageViews.last
            imageView?.addSubview(enterButton)
        }
        if let views = imageDelegate.introducationPageCustomizedView() {
            for (view, position) in views {
                switch position {
                case .pageIndex(let index):
                    let imageView = imageViews[index]
                    imageView.addSubview(view)
                default:
                    addSubview(view)
                }
            }
        }
    }
    init?(frame:CGRect,showNewVersion:Bool = false) {
        guard let info = Bundle.main.infoDictionary,
            let newVersion = info["CFBundleShortVersionString"] as? String else { return nil }
        let oldVersion = UserDefaults.standard.string(forKey: "IntroducationPage-version")
        if (showNewVersion && newVersion == oldVersion) || oldVersion != nil {
            return nil
        } else {
            UserDefaults.standard.set(newVersion, forKey: "GuidePage-version")
        }
        super.init(frame: frame)
        
    }
    public convenience init?(frame:CGRect,
                             videoName:String,
                             delegate:IntroducationVideoProtocol,
                             showNewVersion:Bool = false ) {
        guard let url = Bundle.main.url(forResource: videoName, withExtension: nil) else {
            return nil
        }
        self.init(frame: frame, showNewVersion: showNewVersion)
        self.videoDelegate = delegate
        let player = AVPlayer(url: url)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.contentsScale = UIScreen.main.scale
        playerLayer.frame = frame
        layer.addSublayer(playerLayer)
        player.play()
        delegate.introducationPageDidClickEnterButton(enterButton: enterButton)
        if let views = videoDelegate.introducationPageCustomizedViews() {
            for view in views {
                addSubview(view)
            }
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc fileprivate func enterButtonEvent() {
        removeFromSuperview()
    }
    fileprivate func setupPageControl(_ numberOfPages:Int) {
        pagecControl = PageControl(frame: CGRect(x: 0, y: frame.size.height - 50, width: bounds.size.width, height: 50))
        pagecControl.numberOfPages = numberOfPages
        pagecControl.currentPage = 0
        addSubview(pagecControl)
    }
}
//MARK: - UIScrollView Delegate
extension IntroducationView :UIScrollViewDelegate {
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }
}
