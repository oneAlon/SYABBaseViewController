//
//  SYABTableViewSectionObject.swift
//  Alamofire
//
//  Created by xygj on 2019/3/7.
//

import UIKit

open class SYABTableViewSectionObject: NSObject {
    public var headerHeight: CGFloat = 0.0
    public var headerTitle: String = ""
    public var headerView: UIView?
    
    public var footerHeight: CGFloat = 0.0
    public var footerTitle: String = ""
    public var footerView: UIView?
    
    public var identifier: String = ""
    public var items: [Any] = []
}
