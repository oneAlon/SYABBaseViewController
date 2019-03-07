//
//  SXNBGestureRecognizer.swift
//  Pods-SYABasicUIKit_Example
//
//  Created by xygj on 2019/3/7.
//

import Foundation

public class SYABGestureAction <T: UIGestureRecognizer> {
    
    public typealias GestureRecognizer = (_ gestureRecognizer: T) -> Void

    private var beginHandler: GestureRecognizer? = nil
    private var cancelledHandler: GestureRecognizer? = nil
    private var changeHandler: GestureRecognizer? = nil
    private var endedHandler: GestureRecognizer? = nil
    private var failedHandler: GestureRecognizer? = nil
    
    @objc public func gestureRecognizer(gesture: UIGestureRecognizer) {
        switch gesture.state {
        case .began:
            beginHandler?(gesture as! T)
        case .cancelled:
            cancelledHandler?(gesture as! T)
        case .changed:
            changeHandler?(gesture as! T)
        case .ended:
            endedHandler?(gesture as! T)
        case .failed:
            failedHandler?(gesture as! T)
        case .possible:
            break
        }
    }
    
    public func whenBegan(_ handler: @escaping GestureRecognizer) -> Void {
        beginHandler = handler
//        return self
    }
    
    public func whenCancelled(handler: @escaping GestureRecognizer) -> Void {
        cancelledHandler = handler
//        return self
    }
    
    public func whenChanged(handler: @escaping GestureRecognizer) -> Void {
        changeHandler = handler
//        return self
    }
    
    public func whenEnded(handler: @escaping GestureRecognizer) -> Void {
        endedHandler = handler
//        return self
    }
    
    public func whenFailed(handler: @escaping GestureRecognizer) -> Void {
        failedHandler = handler
//        return self
    }

}
