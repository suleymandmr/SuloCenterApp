//
//  ParibuVC.swift
//  SuloCenterApp
//
//  Created by eyüp yaşar demir on 3.08.2023.
//

import UIKit
import WebKit
@available(iOS 14.0, *)
class ParibuVC: UIViewController {
    var webView: WKWebView = {
        let perfs = WKWebpagePreferences()
        perfs.allowsContentJavaScript = true
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = perfs
        let webView = WKWebView(frame: .zero, configuration: configuration)
        return webView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(webView)
        
        guard let url = URL(string: "https://www.paribucineverse.com/akasya-sinema-salonu") else{
            return
        }
        webView.load(URLRequest(url: url))
        webView.customUserAgent = "iPad/Chrome/SomethingRandom"
        DispatchQueue.main.asyncAfter(deadline: .now() + 5){
            self.webView.evaluateJavaScript("document.body.innerHTML") { result, error in
                guard let html = result as? String , error == nil else {
                    return
                }
                print(html)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
  
}
