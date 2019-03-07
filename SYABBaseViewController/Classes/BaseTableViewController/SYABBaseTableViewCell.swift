//
//  SYABBaseTableViewCell.swift
//  Alamofire
//
//  Created by xygj on 2019/3/7.
//

import UIKit

open class SYABBaseTableViewCell: UITableViewCell {

    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setupSubViews() {
        
    }
    
    open func setCellItem(cellItem: SYABBaseCellItem?) -> Void {
        
    }
    
    open class func cellHeight(forCellItem cellItem: SYABBaseCellItem) -> CGFloat {
        let height = cellItem.cellHeight
        if height > 0 {
            return height
        }
        return 44.0
    }
    
}
