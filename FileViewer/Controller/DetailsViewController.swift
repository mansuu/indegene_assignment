//
//  DetailViewController.swift
//  FileViewer
//
//  Created by Himanshu on 28/08/19.
//  Copyright © 2019 Himanshu. All rights reserved.
//

import UIKit
import WebKit
class DetailsViewController: UIViewController {
    
    
    var file:File?{
        didSet{
            refreshPage()
        }
    }
    
    var webView : WKWebView = {
        let webView = WKWebView(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.backgroundColor = UIColor.clear
        return webView
    }()
    var indicator:UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.color = UIColor.darkGray
        return indicator
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
    }
    
    //MARK :- Add Some views
    func setupViews(){
        self.view.addSubview(webView)
        webView.navigationDelegate = self
        webView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        webView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        webView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        webView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        webView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        view.addSubview(indicator)
        indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        indicator.widthAnchor.constraint(equalToConstant: 32).isActive = true
        indicator.heightAnchor.constraint(equalToConstant: 32).isActive = true
    }
    
    //MARK :- Reload Page to show new content
    func refreshPage(){
        self.loadViewIfNeeded()
        indicator.bringSubviewToFront(self.view)
        indicator.startAnimating()
        webView.evaluateJavaScript("document.documentElement.remove()") { (_, _) in
            self.webView.load(URLRequest(url: URL(string: self.file?.filePath! ?? "")!))
        }
        
    }
    
}



extension DetailsViewController:FileSelectionListener{
    func fileSelected(file: File) {
        self.file = file
    }
}

extension DetailsViewController:WKNavigationDelegate{
    //MARK :- Stop Animating Activity Indicator once Video has started loading
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        if file?.fileType == FileType.video{
            indicator.stopAnimating()
        }
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        indicator.stopAnimating()
    }
    
}
