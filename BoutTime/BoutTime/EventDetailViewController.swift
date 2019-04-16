//
//  EventDetailViewController.swift
//  BoutTime
//
//  Created by Dipanshu Sehrawat on 16/04/19.
//  Copyright © 2019 Dipanshu Sehrawat. All rights reserved.
//

import UIKit
import WebKit

class EventDetailViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var url: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = url {
            let urlRequest = URLRequest(url: url)
            webView.load(urlRequest)
        }
    }
    
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
