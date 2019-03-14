//
//  SYABBaseViewController.swift
//  Alamofire
//
//  Created by xygj on 2019/3/7.
//

import UIKit
import HandyJSON
import SYABNetwork
import SYABasicUIKit

open class SYABBaseViewController: UIViewController, HandyJSON {

    private var models: [SYABBaseRequestModel] = []
    private var isDefaultBackBtn = false
    
    deinit {
        guard models.count > 0 else { return }
        for item in models {
            if item.isKind(of: SYABBaseRequestModel.classForCoder()) {
                let model = item as SYABBaseRequestModel
                model.cancel()
            }
        }
        models.removeAll()
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        
        if self.navigationController != nil {
            self.setNavigationBar()
        }
        
    }
    
    open func setNavigationBar() -> Void {
        self.navigationController!.navigationBar.isTranslucent = false
        self.navigationController!.navigationBar.tintColor = UIColor.white
        //        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.syab_pfSCRegular(ofSize: 17),
        //                                                      NSAttributedString.Key.foregroundColor:
        //                                                        UIColor.syab_defultText]
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(named: "navigationBar"), for: UIBarMetrics.default)
        self.navigationController!.navigationBar.shadowImage = UIImage.init()
    }
    
    @objc public func backToLastViewController() -> Void {
        if (self.navigationController != nil)
            && (self.navigationController?.viewControllers.count)! > 0
            && (self.navigationController?.viewControllers.first != self.navigationController?.topViewController) {
            self.navigationController!.popViewController(animated: true)
        } else if (self.navigationController != nil) {
            self.navigationController!.dismiss(animated: true, completion: nil)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: 导航栏相关设置
    
    public func navBar(title: String?, textColor: UIColor, fontSize: CGFloat) -> Void {
        guard title != nil else {
            self.navigationItem.titleView = nil
            return
        }
        let titleLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 200, height: 44))
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.syab_pfSCRegular(ofSize: fontSize)
        titleLabel.text = title
        titleLabel.sizeToFit()
        self.navigationItem.titleView = titleLabel
    }
    
    public func leftBarItem(title: String, textColor: UIColor, font: UIFont) -> Void {
        self.isDefaultBackBtn = false
        
        let leftButton = UIButton.init(type: UIButton.ButtonType.custom)
        leftButton.frame = CGRect(x: 0, y: 0, width: 80, height:30)
        leftButton.setTitle(title, for: UIControl.State.normal)
        leftButton.setTitleColor(textColor, for: UIControl.State.normal)
        leftButton.titleLabel?.font = font
        leftButton.addTarget(self, action: #selector(SYABBaseViewController.onPressedLeftBarItem), for: UIControl.Event.touchUpInside)
        leftButton.sizeToFit()
        
        let leftBarItem = UIBarButtonItem.init(customView: leftButton)
        self.navigationItem.leftBarButtonItem = leftBarItem
    }
    
    public func leftBarItem(normalImage: UIImage) -> Void {
        self.isDefaultBackBtn = false
        
        let leftButton = UIButton.init(type: UIButton.ButtonType.custom)
        leftButton.frame = CGRect(x: 0, y: 0, width: 80, height:30)
        leftButton.setImage(normalImage, for: UIControl.State.normal)
        leftButton.imageView?.contentMode = .scaleAspectFit
        leftButton.addTarget(self, action: #selector(SYABBaseViewController.onPressedLeftBarItem), for: UIControl.Event.touchUpInside)
        leftButton.sizeToFit()
        
        let leftBarItem = UIBarButtonItem.init(customView: leftButton)
        self.navigationItem.leftBarButtonItem = leftBarItem
    }
    
    public func rightBarItem(title: String, textColor: UIColor, font: UIFont) -> Void {
        self.isDefaultBackBtn = false
        
        let rightButton = UIButton.init(type: UIButton.ButtonType.custom)
        rightButton.frame = CGRect(x: 0, y: 0, width: 80, height:30)
        rightButton.setTitle(title, for: UIControl.State.normal)
        rightButton.setTitleColor(textColor, for: UIControl.State.normal)
        rightButton.titleLabel?.font = font
        rightButton.addTarget(self, action: #selector(SYABBaseViewController.onPressedRightBarItem), for: UIControl.Event.touchUpInside)
        rightButton.sizeToFit()
        
        let rightBarItem = UIBarButtonItem.init(customView: rightButton)
        self.navigationItem.rightBarButtonItem = rightBarItem
    }
    
    
    public func rightBarItem(normalImage: UIImage) -> Void {
        self.isDefaultBackBtn = false
        
        let rightButton = UIButton.init(type: UIButton.ButtonType.custom)
        rightButton.frame = CGRect(x: 0, y: 0, width: 80, height:30)
        rightButton.setImage(normalImage, for: UIControl.State.normal)
        rightButton.imageView?.contentMode = .scaleAspectFit
        rightButton.addTarget(self, action: #selector(SYABBaseViewController.onPressedRightBarItem), for: UIControl.Event.touchUpInside)
        rightButton.sizeToFit()
        
        let rightBarItem = UIBarButtonItem.init(customView: rightButton)
        self.navigationItem.rightBarButtonItem = rightBarItem
    }
    
    
    @objc open func setDefaultBackBarItem() -> Void {
        self.isDefaultBackBtn = true
    }
    
    
    @objc open func onPressedBackBarButton() -> Void {
        
        self.backToLastViewController()
    }
    
    
    @objc open func onPressedLeftBarItem() -> Void {}
    
    @objc open func onPressedRightBarItem() -> Void {}
    
    // MARK: 数据请求相关设置
    
    public func produceModel(_ requestModel: SYABBaseRequestModel) -> Void {
        
        if self.models .contains(requestModel) {
            return;
        }
        
        self.models.append(requestModel)
        
        guard requestModel.errorType != .network else {
            self.handleNetworkError(requestModel)
            return
        }
        
        requestModel.completionHandler = { (model) in

            guard model.resultModel.success else {
                self.handleDataModelError(model)
                return
            }
            
            self.handleDataModelSuccess(model)
        }
        
    }
    
    @objc open func handleDataModelSuccess(_ model: SYABBaseRequestModel) -> Void {
        
    }
    
    @objc open func handleNetworkError(_ model: SYABBaseRequestModel) -> Void {
    }
    
    @objc open func handleDataModelError(_ model: SYABBaseRequestModel) -> Void {
        
    }
    
}
