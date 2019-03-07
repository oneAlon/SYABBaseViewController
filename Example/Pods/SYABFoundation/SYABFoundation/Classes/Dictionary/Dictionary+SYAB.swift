//
//  Dictionary+syab.swift
//  Pods-SYABFoundation_Example
//
//  Created by xygj on 2019/3/7.
//

import Foundation

public extension Dictionary {
    
    public func syab_append(dict: [String: Any]) -> [String: Any] {
        var resultDict = self as? [String: Any]
        for (key, value) in dict {
            guard resultDict != nil else { return Dictionary.init() as! [String : Any]}
            resultDict!.updateValue(value, forKey: key)
        }
        return resultDict!
    }
    
    
    public func syab_jsonData() -> Data? {
        do {
            let data = try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted)
            return data
        } catch  {
            print("异常")
            return nil
        }
    }
    
    public func syab_jsonString() -> String {
        if self.count > 0 {
            let data = self.syab_jsonData()
            guard data != nil else { return "" }
            return String.init(data: data!, encoding: String.Encoding.utf8)!
        }
        return ""
    }
}
