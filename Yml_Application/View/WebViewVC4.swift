//
//  WebViewVC4.swift
//  Yml_Application
//
//  Created by Prakruth Nagaraj on 23/08/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import UIKit
import WebKit

class WebViewVC4: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    var urlStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let webConfigs = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfigs)
        webView.uiDelegate = self as? WKUIDelegate        
        let url = URL(string: self.urlStr)
        let myrequest = URLRequest(url: url!)
        webView.load(myrequest)
        view = webView
    }
}
