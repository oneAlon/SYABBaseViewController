//
//  SYABBaseTableViewController.swift
//  Alamofire
//
//  Created by xygj on 2019/3/7.
//

import UIKit
import MJRefresh
import SYABUtilites
import SYABasicUIKit
import SYABFoundation

open class SYABBaseTableViewController: SYABBaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    public var style = UITableView.Style.plain
    public var sectionArray: [SYABTableViewSectionObject] = []
    public var tableView: UITableView = UITableView.init()
    public var refreshHeader: MJRefreshNormalHeader? = nil
    public var refreshFooter: MJRefreshAutoNormalFooter? = nil
    
    deinit {
        self.tableView.dataSource = nil
        self.tableView.delegate = nil
    }
    
    // MARK: ###################### LifeCycle ######################
    // 初始化时设置Style，默认plain
    public convenience init(style: UITableView.Style) {
        self.init()
        self.style = style
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
    }
    
    // MARK: ###################### Setup ######################
    
    private func setupTableView() -> Void {
        tableView = UITableView.init(frame: self.view.bounds, style: self.style)
        tableView.backgroundColor = UIColor.syab_color(fromHex: "F2F4F6")
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.autoresizingMask = .flexibleHeight
        tableView.sectionHeaderHeight = 0.0
        tableView.sectionFooterHeight = 0.0
        if #available(iOS 11, *) {
            tableView.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
        self.view.addSubview(self.tableView)
    }
    
    open func setPullDownRefresh() -> Void {
        self.refreshHeader = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(SYABBaseTableViewController.pullDownToRefreshAction))
        self.tableView.mj_header = self.refreshHeader
    }
    
    open func setPullUpLoadMore() -> Void {
        self.refreshFooter = MJRefreshAutoNormalFooter.init(refreshingTarget: self, refreshingAction: #selector(SYABBaseTableViewController.pullUpToRefreshAction))
        self.tableView.mj_footer = self.refreshFooter
    }
    
    // MARK: ###################### UITableViewDataSource ######################
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionArray.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionObj: SYABTableViewSectionObject = self.sectionArray.syab_item(atIndex: section) ?? SYABTableViewSectionObject()
        return (sectionObj.items.count)
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionObj: SYABTableViewSectionObject = self.sectionArray.syab_item(atIndex: section) ?? SYABTableViewSectionObject()
        return sectionObj.headerTitle
    }
    
    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let sectionObj: SYABTableViewSectionObject = self.sectionArray.syab_item(atIndex: section) ?? SYABTableViewSectionObject()
        return sectionObj.footerTitle
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = self.item(atIndexPath: indexPath)
        let cellClass: SYABBaseTableViewCell.Type = self.cellCls(forCellItem: item)
        
        let cellID: String = NSStringFromClass(cellClass) + NSStringFromClass(cellClass)
        var cell: SYABBaseTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellID) as? SYABBaseTableViewCell
        if cell == nil {
            tableView.register(cellClass, forCellReuseIdentifier: cellID)
            cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? SYABBaseTableViewCell
        }
        
        guard cell != nil else {
            return SYABBaseTableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "SYABBaseTableViewCellSYABBaseTableViewCellSYABBaseTableViewCell")
        }
        
        self.configForCell(cell!, cellItem: item)
        cell!.setCellItem(cellItem: item)
        
        return cell!
    }
    
    // MARK: ###################### UITableViewDelegate ######################
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionObj: SYABTableViewSectionObject = self.sectionArray.syab_item(atIndex: section) ?? SYABTableViewSectionObject()
        return sectionObj.headerHeight
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let sectionObj: SYABTableViewSectionObject = self.sectionArray.syab_item(atIndex: section) ?? SYABTableViewSectionObject()
        return sectionObj.footerHeight
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionObj: SYABTableViewSectionObject = self.sectionArray.syab_item(atIndex: section) ?? SYABTableViewSectionObject()
        return sectionObj.headerView
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let sectionObj: SYABTableViewSectionObject = self.sectionArray.syab_item(atIndex: section) ?? SYABTableViewSectionObject()
        return sectionObj.footerView
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let item = self.item(atIndexPath: indexPath)
        let cellClass = self.cellCls(forCellItem: item)
        let height: CGFloat = cellClass.cellHeight(forCellItem: item)
        
        if height > 0 {
            return height
        }
        
        return self.tableView.rowHeight;
        
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cellItem = self.item(atIndexPath: indexPath)
        self.didSelect(forCellItem: cellItem, at: indexPath)
        
    }
    
    // MARK: ###################### Config ######################
    
    open func cellCls(forCellItem cellItem: SYABBaseCellItem) -> SYABBaseTableViewCell.Type {
        return SYABBaseTableViewCell.self as SYABBaseTableViewCell.Type
    }
    
    open func configForCell(_ cell: SYABBaseTableViewCell, cellItem: SYABBaseCellItem) -> Void {}
    
    private func item(atIndexPath indexPath: IndexPath) -> SYABBaseCellItem {
        let sectionObj: SYABTableViewSectionObject = self.sectionArray.syab_item(atIndex: indexPath.section) ?? SYABTableViewSectionObject()
        let item = sectionObj.items.syab_item(atIndex: indexPath.row) ?? SYABBaseCellItem()
        return item as! SYABBaseCellItem
    }
    
    // MARK: ###################### Action ######################
    
    open func didSelect(forCellItem cellItem: SYABBaseCellItem, at indexPath: IndexPath) -> Void {}
    
    @objc open func pullDownToRefreshAction() -> Void {}
    
    @objc open func pullUpToRefreshAction() -> Void {}
    
}
