//
//  ViewController.swift
//  MakeItSlow
//
//  Created by Tyreal Gray on 10/19/16.
//  Copyright © 2016 Tyreal Gray. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    @IBOutlet var webView: UIWebView!
    
    var currentUrl:String?
    
    var isWebInit:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.setWebView()
    }
    
    func setWebView() {
        
        if(!isWebInit){

            goUrl("https://tyrealgray.github.io/MakeItSlow/")
            
            webView.scalesPageToFit = true

            webView.delegate = self
            
            isWebInit = true
        }
        
        if((currentUrl) != nil){
            goUrl(currentUrl!)
            currentUrl = nil
        }
        else
        {
            goUrl("https://tyrealgray.github.io/MakeItSlow/")
        }

    }
    
    private func goUrl(urlStr:String){
        let url:NSURL = NSURL(string:urlStr)!
        let request:NSURLRequest = NSURLRequest(URL:url)
        webView.loadRequest(request)
    }
    
    func setUrlTo(url:String){
        currentUrl = url
    }

}

extension ViewController: UIWebViewDelegate {

    func webViewDidStartLoad(webView: UIWebView) {
        print("loading")
    }

    func webViewDidFinishLoad(webView: UIWebView) {
        print("finished")
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        print("failed")
    }
}


