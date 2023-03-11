//
//  WebViewController.swift
//  wowmate
//
//  Created by 장윤정 on 2023/03/11.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    var destinationURL: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.navigationDelegate = self
                
        openWebpage(destinationURL)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
    }

}


extension WebViewController: WKNavigationDelegate {
    
    func openWebpage(_ url: String ) {
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
