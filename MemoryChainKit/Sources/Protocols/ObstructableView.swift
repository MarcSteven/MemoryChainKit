//
//  ObstructableView.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/21.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation



/// A protocol to indicate that conforming view is obstructing the screen
/// (e.g., interstitial view).
///
/// Such information is useful when certain actions can't be triggered,
/// for example, in-app deep-linking routing.
public protocol ObstructableView { }
