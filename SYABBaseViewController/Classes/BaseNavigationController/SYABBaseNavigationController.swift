//
//  SYABBaseNavigationController.swift
//  Alamofire
//
//  Created by xygj on 2019/3/7.
//

import UIKit
import RTRootNavigationController

open class SYABBaseNavigationController: RTRootNavigationController {

    override open func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override open func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            
        }
        super.pushViewController(viewController, animated: animated)
    }

}
