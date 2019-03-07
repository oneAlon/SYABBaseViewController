//
//  NSNotificationCenter+syab.swift
//  Pods-SYABFoundation_Example
//
//  Created by xygj on 2019/3/7.
//

import Foundation

public extension NotificationCenter {
    
    public func syab_safeAddObserver(observer: Any, selector: Selector, name: Notification.Name, object: Any?) -> Void {
        self.removeObserver(observer, name: name, object: object)
        self.addObserver(observer, selector: selector, name: name, object: object)
    }
    
}
