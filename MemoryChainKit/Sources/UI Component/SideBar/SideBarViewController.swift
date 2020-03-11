//
//  SideBarViewController.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2018/9/23.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation
import UIKit

open class SideBarViewController:UIViewController {
    //MARK: - properties
    public var leftViewController:UIViewController!
    public var mainViewControler:UIViewController!
    public var overlap:CGFloat!
    public var scrollView:UIScrollView!
    public var firstTime:Bool = true
    public required init?(coder aDecoder: NSCoder) {
        assert(false, "use init(leftViewcontroller:mainViewController:overlap")
        super.init(coder: aDecoder)
    }
    //MARK: - init  method
    init(leftViewController:UIViewController,
         mainViewController:UIViewController,
         overlap:CGFloat) {
        self.leftViewController = leftViewController
        self.mainViewControler  =  mainViewController
        self.overlap = overlap
        
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = UIColor.black
        setupScrollView()
        setupViewControllers()
    }
    override open func viewDidLayoutSubviews() {
        if firstTime {
            firstTime = false
            closeMenuAniamted(false)
        }
    }
    func setupScrollView() {
        scrollView = UIScrollView()
        
        
        scrollView.isPagingEnabled = false
        scrollView.bounces = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView]", options: [], metrics: nil, views: ["scrollView":scrollView as Any])
        
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[scrollView]", options: [], metrics: nil, views: ["scrollView":scrollView as Any])
        NSLayoutConstraint.activate(horizontalConstraints + verticalConstraints)
        //Add gestureRecognizer
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped(tapRecognizer:)))
        tapRecognizer.delegate = self
        view.addGestureRecognizer(tapRecognizer)
        
    }
    @objc func viewTapped(tapRecognizer:UITapGestureRecognizer) {
        closeMenuAniamted(true)
    }
    func setupViewControllers() {
        addViewController(leftViewController)
        addViewController(mainViewControler)
        addShadowView(mainViewControler.view)
        
        let views:[String:UIView] = [
            "left":leftViewController.view,
            "main":mainViewControler.view,
            "outer":view]
        
        
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "|[left][main(==outer)]|", options: [.alignAllTop,.alignAllBottom], metrics: nil, views: views)
        let leftWidthConstraint = NSLayoutConstraint(item: leftViewController.view as Any, attribute: .width,relatedBy:.equal , toItem: view, attribute: .width, multiplier: 1.0, constant: -overlap)
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[main(==outer)]|", options: [], metrics: nil, views: views)
        NSLayoutConstraint.activate(horizontalConstraints + verticalConstraints + [leftWidthConstraint])
        
    }
    func  toggleLeftMenuAnimated(_ animated:Bool)  {
        if leftMenuIsOpen() {
            closeMenuAniamted(animated)
            
        }else {
            openLeftMenuAnimated(animated)
        }
    }
   public func closeMenuAniamted(_ animated:Bool) {
        scrollView.setContentOffset(CGPoint(x: leftViewController.view.frame.width, y: 0), animated: animated)
    }
    public func openLeftMenuAnimated( _ animated:Bool) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: animated)
    }
    func leftMenuIsOpen() ->Bool {
        return scrollView.contentOffset.x == 0
    }
    fileprivate func addViewController(_ viewController:UIViewController) {
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(viewController.view)
        addChild(viewController)
        viewController.didMove(toParent: self)
    }
    fileprivate func addShadowView(_ destinationView:UIView) {
        destinationView.layer.shadowPath = UIBezierPath(rect: destinationView.bounds).cgPath
        destinationView.layer.shadowRadius = 2.0
        destinationView.layer.shadowOffset = CGSize(width: 0, height: 0)
        destinationView.layer.shadowOpacity  = 1.0
        destinationView.layer.shadowColor = UIColor.black.cgColor
        
    }
    
}
//MARK: - UIGestrue Tap delegate
extension SideBarViewController :UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let tapLocation = touch.location(in: view)
        let tapWasInOverlapArea = tapLocation.x >= view.bounds.width - overlap
        return tapWasInOverlapArea && leftMenuIsOpen()
    }
}
