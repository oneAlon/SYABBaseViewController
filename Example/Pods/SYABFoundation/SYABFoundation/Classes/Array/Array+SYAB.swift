//
//  Array+syab.swift
//  Pods-SYABFoundation_Example
//
//  Created by xygj on 2019/3/7.
//

import Foundation
import UIKit

public extension Array {
    
    mutating public func syab_remove(by anyObject: Element) -> Void {
        for (index, item) in self.enumerated() {
            let obj = item as AnyObject
            if obj.isEqual(anyObject) {
                self.remove(at: index)
            }
        }
    }
    
    public func syab_item(atIndex index: Int) -> Element? {
        
        guard index >= 0 && index < self.endIndex else {
            return nil
        }
        return self[index]
        
    }
    
    public func syab_index(item: Element) -> Int {
        for (index, element) in self.enumerated() {
            let obj = element as AnyObject
            if(obj.isEqual(item)) {
                return index
            }
        }
        return -1
    }
    
    public func syab_jsonData() -> Data? {
        
        if self.count > 0 {
            do {
                let data = try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted)
                return data
            } catch {
                print("异常")
                return nil
            }
        }
        
        return nil
    }
    
    
    public func syab_jsonString() -> String {
        
        guard self.count > 0 else {
            return ""
        }
        
        let data = self.syab_jsonData()
        guard data != nil else {
            return ""
        }
        
        let string = String.init(data: data!, encoding: String.Encoding.utf8)
        return string!
    }
    
    public func syab_md5(andKey key: String) -> String {
        guard self.count > 0 else {
            return ""
        }

        let array = self as? [String]
        
        guard array != nil else {
            return ""
        }
  
        let sortArr =  array!.sorted { (obj1: String, obj2: String) -> Bool in
            return obj1 < obj2
        }
        
        var sign = sortArr.joined(separator: "&")
        sign = sign + "&\(key)"
        sign = sign.syab_md5String
        return sign
        
    }
    
    public func syab_md5(key: String) -> String {
        guard self.count > 0 else {
            return ""
        }
        
        let array = self as? [String]
        
        guard array != nil else {
            return ""
        }
        
        let sortArr =  array!.sorted { (obj1: String, obj2: String) -> Bool in
            return obj1 < obj2
        }
        
        var sign = sortArr.joined(separator: "&")
        sign = sign + key
        sign = sign.syab_md5String
        return sign
        
    }
    
}
