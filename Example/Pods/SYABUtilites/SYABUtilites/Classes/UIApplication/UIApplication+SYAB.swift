//
//  UIApplication+SYAB.swift
//  Pods-SYABUtilites_Example
//
//  Created by xygj on 2019/3/6.
//

import Foundation
import UIKit

public extension UIApplication {
    /// 打开App Store
    public func syab_openAppStoreReviews(appId: String) {
        let url = "itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=\(appId)"
        openURL(URL(string: url)!)
    }
    
    /// 打开App Store
    public func syab_openAppStore(appId: String) {
        let url = "https://itunes.apple.com/cn/app/id\(appId)?mt=8"
        openURL(URL(string: url)!)
    }
    
    /// 打电话
    public func syab_tel(to telNumber: String) {
        let url = "telprompt://\(telNumber)"
        openURL(URL(string: url)!)
    }
}
