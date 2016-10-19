//
//  WebViewController.swift
//  MakeItSlow
//
//  Created by Tyreal Gray on 10/19/16.
//  Copyright © 2016 Tyreal Gray. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate,WKUIDelegate {
    
    
    var wk: WKWebView!
    var curretUrl: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private typealias wkNavigationDelegate = ViewController
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.wk = WKWebView(frame: self.view.frame)
        
        if((curretUrl) != nil){
            self.wk.loadRequest(NSURLRequest(URL: NSURL(string: curretUrl)!))
        }else{
            self.wk.loadRequest(NSURLRequest(URL: NSURL(string: "https://tyrealgray.github.io/MakeItSlow/")!))
        }
        
        
        self.view.addSubview(self.wk)
        
        self.wk.navigationDelegate = self
        self.wk.UIDelegate = self
        
    }
    
    func goUrl(url: String){
        self.curretUrl = url;
    }
    
}

private typealias wkNavigationDelegate = WebViewController
extension wkNavigationDelegate {
    
    func webView(webView: WKWebView, didFailNavigation navigation: WKNavigation!, withError error: NSError) {
        NSLog(error.debugDescription)
    }
    func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
        NSLog(error.debugDescription)
    }
}

private typealias wkUIDelegate = WebViewController
extension wkUIDelegate {
    
    func webView(webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: () -> Void) {
        let ac = UIAlertController(title: webView.title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        ac.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (aa) -> Void in
            completionHandler()
        }))
        self.presentViewController(ac, animated: true, completion: nil)
    }
}