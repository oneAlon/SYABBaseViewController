//
//  Data+syab.swift
//  Pods-SYABFoundation_Example
//
//  Created by xygj on 2019/3/7.
//

import Foundation

public extension Data {

    public func syab_jsonObj() -> Any? {
        
        do {
            let json = try JSONSerialization.jsonObject(with: self, options: JSONSerialization.ReadingOptions.mutableContainers)
            return json
            
        } catch  {
            print("出错")
            return nil
        }
    
    }
}
