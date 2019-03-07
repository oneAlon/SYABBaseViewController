//
//  UIFont+SYAB.swift
//  Pods-SYABasicUIKit_Example
//
//  Created by xygj on 2019/3/7.
//

import Foundation

public extension UIFont {
    
    static public func syab_thin(ofSize fontSize: CGFloat) -> UIFont {
        let font = UIFont(name: "HelveticaNeue-Light", size: fontSize)
        guard font != nil else {
            return UIFont.systemFont(ofSize:fontSize)
        }
        return font!
    }
    
    static public func syab_normal(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: fontSize)
    }
    
    static public func syab_blod(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize: fontSize)
    }
    
    static public func syab_pfSCMedium(ofSize fontSize: CGFloat) -> UIFont {
        let font = UIFont(name: "PingFangSC-Medium", size: fontSize)
        guard font != nil else {
            return UIFont.systemFont(ofSize:fontSize)
        }
        return font!
    }
    
    static public func syab_pfSCRegular(ofSize fontSize: CGFloat) -> UIFont {
        let font = UIFont(name: "PingFangSC-Regular", size: fontSize)
        guard font != nil else {
            return UIFont.systemFont(ofSize:fontSize)
        }
        return font!
    }
    
    static public func syab_pfSCLight(ofSize fontSize: CGFloat) -> UIFont {
        let font = UIFont(name: "PingFangSC-Light", size: fontSize)
        guard font != nil else {
            return UIFont.syab_thin(ofSize:fontSize)
        }
        return font!
    }
    
    static public func syab_pfSCSemibold(ofSize fontSize: CGFloat) -> UIFont {
        let font = UIFont(name: "PingFangSC-Semibold", size: fontSize)
        guard font != nil else {
            return UIFont.syab_pfSCMedium(ofSize:fontSize)
        }
        return font!
    }
    
    static public func syab_numOfDINMittelschrift(ofSize fontSize: CGFloat) -> UIFont {
        let font = UIFont(name: "DINMittelschrift", size: fontSize)
        guard font != nil else {
            UIFont.loadFont(fontName: "DINMittelschrift.otf")
            if let numFont = UIFont(name: "DINMittelschrift", size: fontSize) {
                return numFont
            }
            return UIFont.systemFont(ofSize:fontSize)
        }
        return font!
    }
    
    private static func loadFont(fontName: String) -> Void {
        
        let mainBundlePath = Bundle.main.bundlePath
        let bundlePath = mainBundlePath + "/UIFont.bundle";
        let bundle = Bundle(path: bundlePath)
        
        guard bundle != nil else {
            return
        }
        
        let resourcePath = bundle!.bundlePath + "/" + fontName
        
        let url = URL(fileURLWithPath: resourcePath)
        
        do {
            let fontData = try Data(contentsOf: url)
            var provider: CGDataProvider? = CGDataProvider(data: fontData as CFData)
            
            guard provider != nil else {
                return
            }
            
            var font: CGFont? = CGFont(provider!)
            guard font != nil else {
                return
            }
            
            if CTFontManagerRegisterGraphicsFont(font!, nil) == false {
                print("error")
            }
            
            
            font = nil
            provider = nil
            
        } catch  {}
        
    }
}
