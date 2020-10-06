//
//  PetDetailsViewController.swift
//  AsurionCodeExercise
//
//  Created by Goel, Shobit on 02/10/20.
//  Copyright © 2020 Goel, Shobit. All rights reserved.
//

import UIKit
import WebKit

class PetDetailsViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    var petContentURL: String?
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let petContentURL = petContentURL, let url = URL(string: petContentURL) else {
            return
        }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
}
