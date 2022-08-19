//
//  WebViewViewController.swift
//  CapitalCities
//
//  Created by Павел Кай on 19.08.2022.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController {

    var cityWiki: String?
    
    lazy var webView: WKWebView = {
        let webView = WKWebView(frame: view.frame)
        let url = URL(string: "https://en.wikipedia.org/wiki/\(cityWiki!)")
        webView.load(URLRequest(url: url!))
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(webView)
    }


}
