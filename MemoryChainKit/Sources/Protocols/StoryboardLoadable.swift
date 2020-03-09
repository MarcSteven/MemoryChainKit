//
//  StoryboardLoadable.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2018/12/31.
//  Copyright © 2018 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit

public protocol StoryboardLoadable {
    static var storyboardName:String { get }
    static var storyboardIdentifier:String { get}
}

extension StoryboardLoadable where Self:UIViewController {
    public static var storyboardName:String {
        return String(describing: self)
    }
    public static var storyboardIdentifier:String {
        return String(describing: self)
    }
    public static func instantiate(fromStoryboardName name:String? = nil) ->Self {
        let storyboardName = name ?? self.storyboardName
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return instantiate(fromStoryboard: storyboard)
        
    }
    public static func instantiate(fromStoryboard storyboard:UIStoryboard) ->Self {
        let identifier = self.storyboardIdentifier
        guard let vc = storyboard.instantiateViewController(withIdentifier: identifier) as? Self else {
            fatalError("Failed to instantiate view controller with identifier = \(identifier) from storyboard")
        }
        return vc
    }
    public static func initial(fromStoryboardNamed name: String? = nil) -> Self {
        let sb = name ?? self.storyboardName
        let storyboard = UIStoryboard(name: sb, bundle: nil)
        return initial(fromStoryboard: storyboard)
    }
    
    public static func initial(fromStoryboard storyboard: UIStoryboard) -> Self {
        guard let vc = storyboard.instantiateInitialViewController() as? Self else {
            fatalError("Failed to instantiate initial view controller from storyboard named \( storyboard )")
        }
        return vc
    }

}
//
extension UINavigationController:StoryboardLoadable {}
extension UITabBarController:StoryboardLoadable {}
extension UISplitViewController :StoryboardLoadable {}
extension UIPageViewController :StoryboardLoadable {}
