//
//  MCPagingViewDelegate.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2023/11/11.
//  Copyright © 2023 Marc Steven(https://marcsteven.top). All rights reserved.
//

import UIKit



@objc public protocol MCPagingContainerViewDelegate: NSObjectProtocol {
    /// 滚动当前子视图时对应的相关数据
    ///
    /// - parameter contentView: 分页滚动内容视图
    /// - parameter progress: 滚动进度值
    /// - parameter currentIndex: 当前子视图的下标值
    /// - parameter targetIndex: 目标子视图的下标值
    @objc optional func pagingContentView(contentView: MCPagingView, progress: CGFloat, currentIndex: Int, targetIndex: Int)
    
    /// 内容视图当前对应子视图的下标值
    ///
    /// - parameter index: 当前子视图的下标值
    @objc optional func pagingContentView(index: Int)
    
    /// 内容视图滚动的方法（仅 SGPagingContentScrollView 实现了该方法）
    @objc optional func pagingContentViewDidScroll()
    
    /// 内容视图开始拖拽的方法
    @objc optional func pagingContentViewWillBeginDragging()
    
    /// 内容视图结束拖拽的方法
    @objc optional func pagingContentViewDidEndDecelerating()
}
