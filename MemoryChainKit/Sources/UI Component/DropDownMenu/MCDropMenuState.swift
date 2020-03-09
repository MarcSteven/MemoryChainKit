//
//  MCDropMenuState.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/6/11.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation

/// 下拉的状态
///
/// - willOpen: 将要打开
/// - didOpen: 已经打开
/// - willClose: 将要关闭
/// - didClose: 已经关闭
public enum MCDropDownState{
    case willOpen
    case didOpen
    case willClose
    case didClose
}
