//
//  webViewController.swift
//  Peppy
//
//  Created by Jaydeep Godhani on 07/07/21.
//

import UIKit
import WebKit

class webViewController: UIViewController {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var webView: WKWebView!
    var titleLabel: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerLabel.text = titleLabel
        webViewSetup()
    }
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func webViewSetup(){
        webView.load(URLRequest(url: URL(string: "https://www.google.co.in/?client=safari&channel=mac_bm")!))
    }
}
