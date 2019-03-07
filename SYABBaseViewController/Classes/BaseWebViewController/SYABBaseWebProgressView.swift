//
//  SYABBaseWebProgressView.swift
//  Alamofire
//
//  Created by xygj on 2019/3/7.
//

import UIKit
import SYABUtilites

class SYABBaseWebProgressView: UIView {
    
    public init(frame: CGRect, color: UIColor) {
        super.init(frame: frame)
        self.backgroundColor = color
        self.isHidden = true
        
    }
    
    public func startLoading() -> Void {
        self.isHidden = false
        self.width = 0.0;
        UIView.animate(withDuration: 0.4, animations: {
            self.width = kSYABScreenWidth * 0.6
        }) { (finished) in
            self.width = kSYABScreenWidth * 0.8
        }
    }
    
    public func endLoading() -> Void {
        UIView.animate(withDuration: 0.2, animations: {
            self.width = kSYABScreenWidth
        }) { (finished) in
            self.isHidden = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
