//
//  UIColor+SYAB.swift
//  Pods-SYABasicUIKit_Example
//
//  Created by xygj on 2019/3/6.
//

import Foundation

public extension UIColor {
    
    /// 十六进制
    static public func syab_color(fromHex hex: String, _ alpha: Double = 1) -> UIColor {
        if hex.count != 6 {
            return UIColor.clear
        }
        let rIndex = hex.index(hex.startIndex, offsetBy: 2)
        let rString = hex[..<rIndex]
        let otherString = hex[rIndex...]
        let gIndex = otherString.index(otherString.startIndex, offsetBy: 2)
        let gString = otherString[..<gIndex]
        let bIndex = hex.index(hex.endIndex, offsetBy: -2)
        let bString = hex[bIndex...]
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: String(rString)).scanHexInt32(&r)
        Scanner(string: String(gString)).scanHexInt32(&g)
        Scanner(string: String(bString)).scanHexInt32(&b)
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(alpha))
    }
    
    /// 随机色
    static public var syab_randomColor: UIColor {
        let r = CGFloat(arc4random() % 256) / 255.0
        let g = CGFloat(arc4random() % 256) / 255.0
        let b = CGFloat(arc4random() % 256) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: 1)
    }
    
}
