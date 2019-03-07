//
//  SYABConst.swift
//  Pods-SYABUtilites_Example
//
//  Created by xygj on 2019/3/6.
//

import Foundation
import UIKit

// MARK: - UI相关
public let kSYABScreenWidth = UIScreen.main.bounds.size.width
public let kSYABScreenHeight = UIScreen.main.bounds.size.height

public func kSYABScreenAutoLayoutScaleCeil(_ x: Double) -> CGFloat {
    let scale = kSYABScreenWidth / 375.0
    return CGFloat(ceil(Double(scale) * x))
}

public let kSYABStatusBarHeight = UIApplication.shared.statusBarFrame.size.height
public let kSYABNavigationBarHeight = CGFloat(44.0)
public let kSYABNavigationAndStatusBarHeight = (kSYABStatusBarHeight+kSYABNavigationBarHeight)

public var kSYABScreenSafeBottomHeight: CGFloat {
    var bottom = CGFloat(0.0)
    if #available(iOS 11.0, *) {
        bottom = (UIApplication.shared.keyWindow?.safeAreaInsets.bottom)!
    }
    return bottom;
}

public let kSYABTabBarHeight = (kSYABScreenSafeBottomHeight + 49.0)

// MARK: - 版本号相关
public let kSYABClientVersion: String = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
public let kSYABCurrentSystemVersion = UIDevice.current.systemVersion

public func kSYABClassType(_ className: String) -> AnyClass {
    let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
    let cls: AnyClass = NSClassFromString(namespace + "." + className)!
    return cls
}

