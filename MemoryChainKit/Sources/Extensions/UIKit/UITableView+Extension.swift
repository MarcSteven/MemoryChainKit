//
//  UITableView+Extension.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/1/31.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit


extension UITableView {
    public static func build(block:@escaping ((UITableView)->Void)) ->UITableView {
        let tableView = UITableView(frame: .zero)
        block(tableView)
        return tableView
    }
    public func setEditing(_ editing:Bool,
                           animated:Bool,
                           completion:@escaping () ->Void) {
        CATransaction.animation({setEditing(editing, animated: animated)}, completinonHandler: completion)
    }
    public func setZoomScale(_ scale:CGFloat,
                             animated:Bool,
                             completion:@escaping () ->Void) {
        CATransaction.animation({setZoomScale(scale, animated: animated)}, completinonHandler: completion)

    }
    public func setBackgroundColor(_ color:UIColor) {
        self.backgroundColor = color
    }
    
    
}

public extension UITableView {
    func scrollToLastRow() {
        let indexPath = IndexPath(row:0,section: 0)
        self.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    func scrollToFirstRow() {
        let indexPath = IndexPath(row: 0, section: 0)
        self.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    func scrollToSelectedRow() {
        let selectedRows = self.indexPathsForVisibleRows
        if let selectedRow = selectedRows?[0] as NSIndexPath? {
            self.scrollToRow(at: selectedRow as IndexPath, at: .middle, animated: true)
        }
    }
    func scrollToHeader() {
        self.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: true)
    }
    func removeEliminateExtraSeparators() {
        self.tableFooterView = UIView(frame: .zero)
        self.tableHeaderView = UIView(frame:.zero)
    }
    func registerCell(_ cellTypes:[AnyClass]) {
        for cellType in cellTypes {
            let typeString = String(describing: cellType)
            let xibPath = Bundle(for: cellType).path(forResource: typeString, ofType: ".nib")
            if xibPath == nil {
                register(cellType, forCellReuseIdentifier: typeString)
            } else {
                register(UINib(nibName: typeString, bundle: nil), forCellReuseIdentifier: typeString)
            }
        }
    }
}

extension UITableView {
    /// Compares the top two visible rows to the current content offset
    /// and returns the best index path that is visible on the top.
    public var visibleTopIndexPath: IndexPath? {
        let visibleRows = indexPathsForVisibleRows ?? []
        let firstPath: IndexPath
        let secondPath: IndexPath

        if visibleRows.isEmpty {
            return nil
        } else if visibleRows.count == 1 {
            return visibleRows.first
        } else {
            firstPath = visibleRows[0]
            secondPath = visibleRows[1]
        }

        let firstRowRect = rectForRow(at: firstPath)
        return firstRowRect.origin.y > contentOffset.y ? firstPath : secondPath
    }

    /// A convenience property for the index paths representing the selected rows.
    /// This simply return empty array when there are no selected rows instead of `nil`.
    ///
    /// ```swift
    /// return indexPathsForSelectedRows ?? []
    /// ```
    public var selectedIndexPaths: [IndexPath] {
        indexPathsForSelectedRows ?? []
    }

    /// The total number of rows in all the sections.
    public var numberOfRowsInAllSections: Int {
        var rows = 0
        for i in 0..<numberOfSections {
            rows += numberOfRows(inSection: i)
        }
        return rows
    }

    /// Selects a row in the table view identified by index path, optionally scrolling the row to a location in the table view.
    ///
    /// Calling this method does not cause the delegate to receive a `tableView:willSelectRowAtIndexPath:` or
    /// `tableView:didSelectRowAtIndexPath:` message, nor does it send `UITableViewSelectionDidChangeNotification`
    /// notifications to observers.
    ///
    /// Passing `UITableViewScrollPositionNone` results in no scrolling, rather than the minimum scrolling described for that constant.
    /// To scroll to the newly selected row with minimum scrolling, select the row using this method with `UITableViewScrollPositionNone`,
    /// then call `scrollToRowAtIndexPath:atScrollPosition:animated:` with `UITableViewScrollPositionNone`.
    ///
    /// - Parameters:
    ///   - indexPaths:     An array of index paths identifying rows in the table view.
    ///   - animated:       Pass `true` if you want to animate the selection and any change in position;
    ///                     Pass `false` if the change should be immediate.
    ///   - scrollPosition: A constant that identifies a relative position in the table view (top, middle, bottom)
    ///                     for the row when scrolling concludes. The default value is `UITableViewScrollPositionNone`.
    public func selectRows(at indexPaths: [IndexPath], animated: Bool, scrollPosition: ScrollPosition = .none) {
        indexPaths.forEach {
            selectRow(at: $0, animated: animated, scrollPosition: scrollPosition)
        }
    }

    /// Deselects all selected rows, with an option to animate the deselection.
    ///
    /// Calling this method does not cause the delegate to receive a `tableView:willDeselectRowAtIndexPath:`
    /// or `tableView:didDeselectRowAtIndexPath:` message, nor does it send `UITableViewSelectionDidChangeNotification`
    /// notifications to observers.
    ///
    /// - Parameter animated: true if you want to animate the deselection, and false if the change should be immediate.
    public func deselectAllRows(animated: Bool) {
        indexPathsForSelectedRows?.forEach {
            deselectRow(at: $0, animated: animated)
        }
    }

    }
@objc public protocol TableViewCellIdentifier:AnyObject {
    static var reuseIdentifier:String {get}
}
extension UITableView {
    public func dequeueReusableCell(ofClass cls:TableViewCellIdentifier.Type,
                                    for indexPath:IndexPath) ->UITableViewCell {
        let identifier = cls.reuseIdentifier
        let cell = dequeueReusableCell(withIdentifier:identifier,for:indexPath)
        if type(of:cell) != cls  {
            fatalError("Expected to dequeue cell of class \"\(NSStringFromClass(cls) as String)\" for identifier \"\(identifier).\" Instead, a cell of class \"\(NSStringFromClass(type(of: cell)) as String)\" was returned.")
        }
        if let dataSource = dataSource {
                let constructedMethodName = "tableView:configure\(NSStringFromClass(type(of: cell)) as String):forIndexPath:" as NSString
                
                let selector = sel_registerName((constructedMethodName as NSString).utf8String!)
                let method   = class_getInstanceMethod(type(of: dataSource), selector)
                
                if let method = method {
                    let implementation = method_getImplementation(method)
                    let callable       = unsafeBitCast(implementation, to: (@convention(c) (AnyObject, Method, UITableView, UITableViewCell, IndexPath) -> Void).self)
                    
                    callable(dataSource, method, self, cell, indexPath)
                }
            }
            
            return cell
        }
    }

extension UITableView {
    /// Adjust target offset so that cells are snapped to top.
    ///
    /// Call this method in scroll view delegate:
    ///```swift
    /// func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    ///     snapRowsToTop(targetContentOffset, cellHeight: cellHeight, headerHeight: headerHeight)
    /// }
    ///```
    public func snapRowsToTop(_ targetContentOffset: UnsafeMutablePointer<CGPoint>, cellHeight: CGFloat, headerHeight: CGFloat) {
        // Adjust target offset so that cells are snapped to top
        let section = (indexPathsForVisibleRows?.first?.section ?? 0) + 1
        targetContentOffset.pointee.y -= (targetContentOffset.pointee.y.truncatingRemainder(dividingBy: cellHeight)) - (CGFloat(section) * headerHeight)
    }

    private func snapRowsToTop(_ targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // TODO: This can be use to handles a table view with varying row and section heights. Still needs testing
        // Find the indexPath where the animation will currently end.
        let indexPath = indexPathForRow(at: targetContentOffset.pointee) ?? IndexPath(row: 0, section: 0)

        var offsetY: CGFloat = 0
        for s in 0..<indexPath.section {
            for r in 0..<indexPath.row {
                let indexPath = IndexPath(row: r, section: s)
                var rowHeight = delegate?.tableView?(self, heightForRowAt: indexPath) ?? 0
                var sectionHeaderHeight = delegate?.tableView?(self, heightForHeaderInSection: s) ?? 0
                var sectionFooterHeight = delegate?.tableView?(self, heightForFooterInSection: s) ?? 0
                rowHeight = rowHeight == 0 ? self.rowHeight : rowHeight
                sectionFooterHeight = sectionFooterHeight == 0 ? self.sectionFooterHeight : sectionFooterHeight
                sectionHeaderHeight = sectionHeaderHeight == 0 ? self.sectionHeaderHeight : sectionHeaderHeight
                offsetY += rowHeight + sectionHeaderHeight + sectionFooterHeight
            }
        }

        // Tell the animation to end at the top of that row.
        targetContentOffset.pointee.y = offsetY
    }
}
public extension UITableView {

    /// Gets the currently visibleCells of a section.
    ///
    /// - Parameter section: The section to filter the cells.
    /// - Returns: Array of visible UITableViewCell in the argument section.
    func visibleCells(in section: Int) -> [UITableViewCell] {
        return visibleCells.filter { indexPath(for: $0)?.section == section }
    }
}
public extension UITableView {
    func ConfigureProtocols() {
        self.delegate = self as? UITableViewDelegate
        self.dataSource = (self as? UITableViewDataSource)
    }
    func configureHeaderView() {
        self.tableHeaderView = UIView(frame: .zero)
    }
    func configureFooterView() {
        self.tableFooterView = UIView(frame: .zero)
    }
}
