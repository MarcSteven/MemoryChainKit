//
//  MCTableViewDataSource.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/19.
//  Copyright © 2020 Marc Steven(.com/MarcSteven). All rights reserved.
//

import UIKit



@objcMembers
open class MCTableViewDataSource: NSObject, UITableViewDataSource {
    /// UITableView has bug that ignored zero when sent as the `heightForFooterInSection`
    /// It has to be number greater then zero. Hence, this declaration.
    public static let zero: CGFloat = 0.0001

    /// Global section index.
    open var globalSection = 0

    /// The table view of the data source.
    open weak var tableView: UITableView?

    override init() {
        super.init()
    }

    public init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
    }
}

// MARK: UITableViewDelegate

extension MCTableViewDataSource {
    open func heightForRow(at indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    open func heightForHeaderInSection(_ section: Int) -> CGFloat {
        UITableView.automaticDimension
    }

    open func heightForFooterInSection(_ section: Int) -> CGFloat {
        UITableView.automaticDimension
    }

    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        nil
    }

    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        nil
    }

    open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }

    open func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }

    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

// MARK: UITableViewDataSource

extension MCTableViewDataSource {
    @objc(numberOfSectionsInTableView:)
    open func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }

    @objc(tableView:cellForRowAtIndexPath:)
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        fatalError(because: .subclassMustImplement)
    }

    open func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        nil
    }

    open func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        nil
    }
}

