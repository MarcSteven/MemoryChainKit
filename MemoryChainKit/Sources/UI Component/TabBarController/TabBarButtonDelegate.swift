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

public protocol TabBarButtonDelegate:AnyObject {
    func shouldAnimate(_ tabBarButton: TabBarButton)->Bool
    
    
    /// The start animation duration.
    ///
    /// - Parameter tabBarButton: The sender.
    func beginAnimationDuration(_ tabBarButton: TabBarButton)->TimeInterval
    
    
    /// The ending animation duration.
    ///
    /// - Parameter tabBarButton: The sender.
    func endAnimationDuration(_ tabBarButton: TabBarButton)->TimeInterval
    
    
    /// The initial Spring Velocity for the ending animation.
    ///
    /// - Parameter tabBarButton: The sender.
    func initialSpringVelocity(_ tabBarButton: TabBarButton)->CGFloat
    
    
    /// The Spring Damping value.
    ///
    /// - Parameter tabBarButton: The sender.
    /// - Returns: The value of the damping
    func usingSpringWithDamping(_ tabBarButton: TabBarButton)->CGFloat
    
    
    /// Function used to decide if the action of the button can be triggered using a long click gesture.
    ///
    /// - Parameter tabBarButton: The sender.
    /// - Returns: True if you wish to enable long-click-gesture for the button.
    func shouldLongClick(_ tabBarButton: TabBarButton)->Bool
    
    
    /// Set the duration that takes for the long click gesture to be triggered.
    ///
    /// - Parameter tabBarButton: The sender.
    /// - Returns: The duration that takes for the long click gesture to be triggered.
    func longClickTriggerDuration(_ tabBarButton: TabBarButton)-> TimeInterval
    
    
    /// A function that is invoked when long-click gesture occurs.
    ///
    /// - Parameter tabBarButton: The sender.
    func longClickAction(_ tabBarButton: TabBarButton)
}


