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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
