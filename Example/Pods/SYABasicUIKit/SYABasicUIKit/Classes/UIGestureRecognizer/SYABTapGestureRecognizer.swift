//
//  SXNBTapGestureRecognizer.swift
//  Pods-SYABasicUIKit_Example
//
//  Created by xygj on 2019/3/7.
//

import Foundation

public class SYABTapGestureRecognizer: UITapGestureRecognizer {
    
    public typealias GestureAction = (_ gesture: UITapGestureRecognizer) -> Void
    
    public var singleGestureAction: GestureAction? = nil
    public var gestureAction = SYABGestureAction<UITapGestureRecognizer>()

    public init() {
        super.init(target: gestureAction, action: #selector(gestureAction.gestureRecognizer(gesture:)))
//        action(self)
    }
    
}
