//
// MemoryChainKit
// Copyright © 2019 Marc Steven
// MIT license, see LICENSE file for details
//

import UIKit


open class MCTableViewCell:UITableViewCell {
    //MARK: - init method
    public convenience init() {
        self.init(style:.default,reuseIdentifier:nil)
    }
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        internalCommonInit()
    }
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        internalCommonInit()
    }
    
    //MARK: - setup method
    open override func setSelected(_ selected: Bool, animated: Bool) {
        
    }
    open override func setHighlighted(_ highlighted: Bool, animated: Bool) {
    
        
    }
    private func internalCommonInit() {
        backgroundColor = .clear
    }
    
    /// The default implementation of this method does nothing
    ///Subclass can override it to perform additional actions
    open func commonInit() {}
}
