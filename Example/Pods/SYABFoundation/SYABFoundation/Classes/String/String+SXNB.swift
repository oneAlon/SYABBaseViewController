//
//  String+syab.swift
//  Pods-SYABFoundation_Example
//
//  Created by xygj on 2019/3/7.
//

import Foundation
import CommonCrypto

public extension String {
    
    public var syab_md5String: String {
        let cStrl = cString(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue));
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 16);
        CC_MD5(cStrl, CC_LONG(strlen(cStrl!)), buffer);
        var md5String = "";
        for idx in 0...15 {
            let obcStrl = String.init(format: "%02x", buffer[idx]);
            md5String.append(obcStrl);
        }
        free(buffer);
        return md5String;
    }
    
    
    public func syab_urlEncoded() -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
            .urlQueryAllowed)
        return encodeUrlString ?? ""
    }
    
    public func syab_jsonValue() -> Any? {
        let data = self.data(using: String.Encoding.utf8)
        guard data != nil else {
            return nil
        }
        do {
            
            let jsonValue = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
            return jsonValue
            
        } catch  {
            return nil
        }
        
    }
    
    public func syab_urlConvertJson() -> Any? {
        guard self.count > 0 else {
            return nil
        }
        var jsonValue = self.replacingOccurrences(of: "&", with: "\",\"")
        jsonValue = jsonValue.replacingOccurrences(of: "=", with: "\":\"")
        jsonValue = "{\"" + jsonValue + "\"}"
        return jsonValue.syab_jsonValue
    }
    
    public func syab_urlConvertDictionary() -> [String: Any]? {
        guard self.count > 0 else {
            return nil
        }
        let parameterString = self.syab_urlEncoded()
        let parameterArr = parameterString.components(separatedBy: "&")
        var resultDic: [String: Any] = [:]
        for item in parameterArr {
            let array = item.components(separatedBy: "=")
            guard array.count > 0 else { return nil}
            let key = array.first
            let value = array.last
            guard value != nil else { return nil }
            var valueStr: Any = ""
            if (value!.hasPrefix("{") && value!.hasSuffix("}")) || value!.hasPrefix("[") && value!.hasSuffix("]") {
                let data = value!.data(using: String.Encoding.utf8)
                do {
                    valueStr = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
                    
                } catch {
                    
                }
                
                guard key != nil else { return nil }
                
                resultDic.updateValue(valueStr, forKey: key!)
                
            }
            
        }
        return resultDic
    }
    
    public func syab_validEmail() -> Bool {
        let emailRegex = "'[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}'"
        let predicate = NSPredicate(format: "SELF MATCHES \(emailRegex)", argumentArray: nil)
        return predicate.evaluate(with: self)
    }
    
    public func syab_validMobile() -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES '^[0-9]{11}'", argumentArray: nil)
        return predicate.evaluate(with:self)
    }
    
    public func syab_validFixPhone() -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES '^[0-9]{10,12}'", argumentArray: nil)
        return predicate.evaluate(with:self)
    }
    
    public func syab_validIDCard() -> Bool {
        let cardRegex = "'^(\\d{14}|\\d{17})(\\d|[xX])$'"
        let predicate = NSPredicate(format: "SELF MATCHES \(cardRegex)", argumentArray: nil)
        return predicate.evaluate(with:self)
    }
    
    public func syab_allNumbers() -> Bool {
        
        if self.count < 1 {
            return false
        }
        
        for item in self {
            var number = 0
            for scalar in String(item).unicodeScalars {
                //字符串只有一个字符，这个循环只会执行1次
                number = Int(scalar.value)
            }
            
            if isnumber(Int32(number)) == 0 {
                return false
            }
        }
        
        return true
    }
    
    public func syab_allDecimalDigit() -> Bool {
        if self.count < 1 {
            return false
        }
        let temp = self.trimmingCharacters(in: CharacterSet.decimalDigits)
        if temp == "." {
            return true
        }
        return false
    }
    
   public func syab_validNumbers(limit length: Int) -> String {
        var number = ""
        if self.syab_allNumbers() {
            if self.count < length {
                return self
            }
            let index = self.index(self.startIndex, offsetBy: length)
            number = String(self[self.startIndex..<index])
        }
        return number
    }
    
    public func syab_onlyChinese() -> Bool {
        let regex = "'[\\u4e00-\\u9fa5]+'"
        let predicate = NSPredicate(format: "SELF MATCHES \(regex)", argumentArray: nil)
        return predicate.evaluate(with:self)
    }
    
    public func syab_containsChinese() -> Bool {
        
        for item in self {
            let temp = String(item)
            if temp.syab_onlyChinese() == true {
                return true
            }
        }
        
        return false
    }
    
    public func syab_validChinese() -> String {
        var chinese = ""
        for item in self {
            let temp = String(item)
            if temp.syab_onlyChinese() == true {
                chinese += temp
            }
        }
        return chinese
    }
    
    public func syab_validTrueName(limit length: Int) -> String {
        var trueName = ""
        for item in self {
            let temp = String(item)
            if temp.syab_onlyChinese() == true {
                trueName += temp
            }
            if temp == "·" {
                trueName += temp
            }
        }
        
        if trueName.count < length {
            return trueName
        }
        
        let index = trueName.index(trueName.startIndex, offsetBy: length)
        trueName = String(trueName[trueName.startIndex..<index])
        return trueName
    }
    
    public func syab_onlyNumbersAndEnglish() -> Bool {
        let regex = "'[a-zA-Z0-9]*'"
        let predicate = NSPredicate(format: "SELF MATCHES \(regex)", argumentArray: nil)
        return predicate.evaluate(with:self)
    }
    
    public var syab_containsEmoji: Bool {
        return unicodeScalars.contains { $0.syab_isEmoji }
    }
    
}


