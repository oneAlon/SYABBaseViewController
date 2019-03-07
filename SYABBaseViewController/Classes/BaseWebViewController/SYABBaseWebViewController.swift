//
//  SYABBaseWebViewController.swift
//  Alamofire
//
//  Created by xygj on 2019/3/7.
//

import UIKit
import MJRefresh
import SYABUtilites
import WebViewJavascriptBridge

public protocol SYABBaseWebViewDelegate {
    
    func loadCloseBarItem() -> Void
    func startWebViewLoading() -> Void
    func pullDownToRefresh() -> Void
    func registerJSMethods() -> Void
    
}

open class SYABBaseWebViewController: SYABBaseViewController, SYABBaseWebViewDelegate, UIWebViewDelegate {
    
    public var webView: UIWebView = UIWebView.init()
    public var urlString = ""
    public var initialTitle: String? = nil // 第一次进入时的标题
    public var webViewDelegate: SYABBaseWebViewDelegate? = nil
    public var webViewBridge: WebViewJavascriptBridge? = nil
    public var refreshHeader: MJRefreshNormalHeader? = nil
    private var _progressColor: UIColor = UIColor.blue
    
    private var closeBarItem: UIBarButtonItem? = nil
    
    deinit {
        self.webView.scrollView.delegate = nil
        self.webView.delegate = nil
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.setWebView()
        self.registerJSMethods()
        self.startWebViewLoading()
    }
    
    // MARK:  =====================  Setup  =====================
    
    func setWebView() -> Void {
    
        self.webView.frame = self.view.bounds
        self.webView.scalesPageToFit = true
        self.webView.isUserInteractionEnabled = true
        self.webView.isOpaque = true
        self.webView.autoresizingMask = .flexibleHeight
        self.view.addSubview(self.webView)
        self.webViewDelegate = self
        self.webView.keyboardDisplayRequiresUserAction = true
        self.webView.delegate = self as UIWebViewDelegate
        self.view.addSubview(self.progressView)
        
        if #available(iOS 11.0, *) {
            self.webView.scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
    }
    
    
    
    override open func onPressedBackBarButton() {
        if self.webView.canGoBack {
            self.webView.goBack()
        } else {
            self.backToLastViewController()
        }
    }
    
    // MARK:  =====================  Property  =====================
    
    private lazy var progressView: SYABBaseWebProgressView = {
        let progressView = SYABBaseWebProgressView.init(frame: CGRect(x: 0, y: 0, width: kSYABScreenWidth, height: 2.0), color: self.progressColor)
        return progressView
    }()
    
    public var progressColor: UIColor {
        get {
            return _progressColor
        }
        set {
            _progressColor = newValue
            self.progressView.backgroundColor = newValue
        }
    }
    
    public func setPullDownRefresh() -> Void {
        self.refreshHeader = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(SYABBaseWebViewController.pullDownToRefresh))
        self.webView.scrollView.mj_header = self.refreshHeader
    }
    
    // MARK:  =====================  Methods  =====================
    
    public func cleanWebViewCookies(ByURL url: String) -> Void {
        let cookiesArr: [HTTPCookie]? = HTTPCookieStorage.shared.cookies(for: URL(string: url)!)
        guard cookiesArr != nil else {
            return
        }
    
        for cookie in cookiesArr! {
            HTTPCookieStorage.shared.deleteCookie(cookie)
        }
    }
    
    public func cleanWebViewCookies() {
        guard HTTPCookieStorage.shared.cookies != nil else {
            return
        }
    
        for cookie in HTTPCookieStorage.shared.cookies! {
            HTTPCookieStorage.shared.deleteCookie(cookie)
        }
    }
    
    // MARK:  =====================  WebViewProtocol  =====================
    
    open func loadCloseBarItem() {
        let closeItem = UIButton.init(type: UIButton.ButtonType.custom)
        closeItem.setTitle("关闭", for: UIControl.State.normal)
        closeItem.setTitleColor(UIColor.black, for: UIControl.State.normal)
        closeItem.addTarget(self, action: #selector(SYABBaseWebViewController.backToLastViewController), for: UIControl.Event.touchUpInside)
        self.closeBarItem = UIBarButtonItem.init(customView: closeItem)
        self.navigationItem.leftBarButtonItems = [self.navigationItem.leftBarButtonItem, self.closeBarItem] as? [UIBarButtonItem]
    }
    
    open func startWebViewLoading() {
        guard self.urlString.count > 0 else {
            return
        }
        let reqest: URLRequest = URLRequest(url: URL(string: self.urlString)!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 15.0)
        self.webView.loadRequest(reqest)
        }
    
    @objc open func pullDownToRefresh() -> Void {
    
    }
    
    private func _showCloseBarItem() -> Void {
        if self.webView.canGoBack {
            self.loadCloseBarItem()
        } else {
            self.navigationItem.leftBarButtonItems = nil
            self.setDefaultBackBarItem()
        }
    }
    
    private func setWebViewBridge() -> Void {
        WebViewJavascriptBridge.enableLogging()
        self.webViewBridge = WebViewJavascriptBridge.init(self.webView)
        self.webViewBridge!.setWebViewDelegate(self)
    }
    
    // MARK:  =====================  registerJSMethods  =====================
    
    open func registerJSMethods() {
        self.setWebViewBridge()
    }
    
    // MARK:  =====================  UIWebViewDelegate  =====================
    
    public func webViewDidStartLoad(_ webView: UIWebView) {
        self.progressView.startLoading()
    }
    
    public func webViewDidFinishLoad(_ webView: UIWebView) {
    
    self.progressView.endLoading()
    
    let pageTitle: String? = webView.stringByEvaluatingJavaScript(from: "document.title")
    
        if pageTitle != nil {
            self.title = webView.canGoBack ? pageTitle : (self.initialTitle != nil ? self.initialTitle : pageTitle)
        }
    
        self._showCloseBarItem()
    
        guard self.refreshHeader != nil else {
            return
        }
        self.refreshHeader?.endRefreshing()
    }
    
    public func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        self.progressView.endLoading()
        self._showCloseBarItem()
    
        guard self.refreshHeader != nil else {
            return
        }
        self.refreshHeader?.endRefreshing()
    }
    
}

