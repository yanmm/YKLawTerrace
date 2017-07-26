//
//  YKHTMLController.swift
//  YKProject
//
//  Created by Yuki on 16/9/7.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import UIKit

class YKHTMLController: YKBaseViewController,UIWebViewDelegate {
    fileprivate var webView : UIWebView?
    fileprivate var noDataView = YKNoDataView.show("网络繁忙，请稍后再试", btnTitle: nil)
    var urlStr: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        noDataView.frame = self.view.frame
        let webView = UIWebView.init()
        self.view.addSubview(webView)
        webView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(0)
        }
        if let urlStr = urlStr {
            if urlStr == kAPI_HOST_HTTP {
                self.noDataView.messageLabel.text = "暂无H5页面"
                self.view.addSubview(self.noDataView)
            } else {
                self.noDataView.messageLabel.text = "网络繁忙，请稍后再试"
                if let url = URL(string: urlStr) {
                    webView.loadRequest(URLRequest(url: url))
                }
            }
        }
        webView.scalesPageToFit = true
        webView.delegate = self
    }
    
    // MARK: - UIWebViewDelegate
    
    func webViewDidStartLoad(_ webView: UIWebView) {
//        YKProgressHUD.popup(nil, inView: self.view, global: true)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
//        YKProgressHUD.hide(true)
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
//        YKProgressHUD.hide(true)
        self.view.addSubview(noDataView)
    }
}
