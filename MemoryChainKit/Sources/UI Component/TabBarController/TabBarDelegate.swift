//
//  TabBarButtonDelegate.swift
//  NiceMind
//
//  Created by Marc Zhao on 2018/1/12.
//  Copyright © 2018年 Knightsmind techonology co,LTD. All rights reserved.
//

import Foundation

import UIKit
import AVFoundation

public protocol TabBarDelegate: class {
    
    /// This function is called after `didMoveToTabAtIndex` is called. In order for this function to work you must override the var `childViewControllerForStatusBarStyle` in the root controller to return this instance of AZTabBarController.
    ///
    /// - Parameters:
    ///   - tabBar: The current instance of AZTabBarController.
    ///   - index: The index of the child view controller which you wish to set a status bar style for.
    /// - Returns: The status bar style.
    func tabBar(_ tabBar: TabBarController, statusBarStyleForIndex index: Int)-> UIStatusBarStyle
    
    
    /// This function is called whenever user clicks the menu a long click. If returned false, the action will be ignored.
    ///
    /// - Parameters:
    ///   - tabBar: The current instance of AZTabBarController.
    ///   - index: The index of the child view controller which you wish to disable the long menu click for.
    /// - Returns: true if you wish to allow long-click interaction for a specific tab, false otherwise.
    func tabBar(_ tabBar: TabBarController, shouldLongClickForIndex index: Int)-> Bool
    
    
    /// Should the tab be switched to the new tab at a given index.
    ///
    /// - Parameters:
    ///   - tabBar: The current instance of AZTabBarController.
    ///   - index: The index of the child view controller which the controller is about to change to.
    /// - Returns: true to move and false to ignore.
    func tabBar(_ tabBar: TabBarController, shouldMoveToTabAtIndex index: Int)-> Bool
    
    
    /// This function is used to enable/disable animation for a certian tab.
    ///
    /// - Parameters:
    ///   - tabBar: The current instance of AZTabBarController.
    ///   - index: The index of the tab.
    /// - Returns: true if you wish to enable the animation, false otherwise.
    func tabBar(_ tabBar: TabBarController, shouldAnimateButtonInteractionAtIndex index:Int)-> Bool
    
    
    /// This function is used to play a sound when a certain tab is selected.
    ///
    /// - Parameters:
    ///   - tabBar: The current instance of the tab bar controller.
    ///   - index: The index you wish to play sound for.
    /// - Returns: The system sound id. if nil is returned nothing will be played.
    func tabBar(_ tabBar: TabBarController, systemSoundIdForButtonAtIndex index:Int)-> SystemSoundID?
    
    
    /// This function is called whenever user taps one of the menu buttons.
    ///
    /// - Parameters:
    ///   - tabBar: The current instance of AZTabBarController.
    ///   - index: The index of the menu the user tapped.
    func tabBar(_ tabBar: TabBarController, didSelectTabAtIndex index: Int)
    
    
    /// This function is called whenever user taps and hold one of the menu buttons. Note that this function will not be called for a certain index if `shouldLongClickForIndex` is implemented and returns false for that very same index.
    ///
    /// - Parameters:
    ///   - tabBar: The current instance of AZTabBarController.
    ///   - index: The index of the menu the user long clicked.
    func tabBar(_ tabBar: TabBarController, didLongClickTabAtIndex index:Int)
    
    
    /// This function is called before the child view controllers are switched.
    ///
    /// - Parameters:
    ///   - tabBar: The current instance of AZTabBarController.
    ///   - index: The index of the controller which the tab bar will be switching to.
    func tabBar(_ tabBar: TabBarController, willMoveToTabAtIndex index:Int)
    
    
    /// This function is called after the child view controllers are switched.
    ///
    /// - Parameters:
    ///   - tabBar: The current instance of AZTabBarController.
    ///   - index: The index of the controller which the tab bar had switched to.
    func tabBar(_ tabBar: TabBarController, didMoveToTabAtIndex index: Int)
    
}

//The point of this extension is to make the delegate functions optional.
public extension TabBarDelegate{
    
    func tabBar(_ tabBar: TabBarController, statusBarStyleForIndex index: Int)-> UIStatusBarStyle { return .default }
    
    func tabBar(_ tabBar: TabBarController, shouldLongClickForIndex index: Int)-> Bool { return true }
    
    func tabBar(_ tabBar: TabBarController, shouldAnimateButtonInteractionAtIndex index:Int)-> Bool { return true }
    
    func tabBar(_ tabBar: TabBarController, shouldMoveToTabAtIndex index: Int)-> Bool { return true }
    
    func tabBar(_ tabBar: TabBarController, systemSoundIdForButtonAtIndex index:Int)-> SystemSoundID? {return nil}
    
    func tabBar(_ tabBar: TabBarController, didSelectTabAtIndex index: Int){}
    
    func tabBar(_ tabBar: TabBarController, didLongClickTabAtIndex index:Int){}
    
    func tabBar(_ tabBar: TabBarController, willMoveToTabAtIndex index:Int){}
    
    func tabBar(_ tabBar: TabBarController, didMoveToTabAtIndex index: Int){}
}
