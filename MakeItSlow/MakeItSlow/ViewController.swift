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
    
    var isInit:Bool = false

    var currentUrl:String?
    
    var guestNames:[ContactItem]?
    
    @IBOutlet var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()

        self.setWebView()
    }
    
    private func setWebView(){
        
        if(!isInit){
            
            isInit = true
            
            goUrl("https://tyrealgray.github.io/MakeItSlow/")
            
            webView.scalesPageToFit = true
            
            webView.delegate = self
            
        }
        else if((currentUrl) != nil){
            
            goUrl(currentUrl!)
            currentUrl = nil
        }
        
        if((guestNames) != nil){
            goUrl("https://tyrealgray.github.io/MakeItSlow/profile.html")
        }
    }
    
    func inviteGuest(guests:[ContactItem]){
        
        guestNames = guests
    }
    
    private func goUrl(urlStr:String){
        let url:NSURL = NSURL(string:urlStr)!
        let request:NSURLRequest = NSURLRequest(URL:url)
        webView.loadRequest(request)
    }
    
    func setUrlTo(url:String){
        self.currentUrl = url
        
    }

}

extension ViewController: UIWebViewDelegate {

    func webViewDidStartLoad(webView: UIWebView) {
        print("loading")
    }

    func webViewDidFinishLoad(webView: UIWebView) {
        print("finished")
        
        if((guestNames) != nil){
            
            self.webView.stringByEvaluatingJavaScriptFromString("clearGuest()")

            
            for guest in guestNames!{
                self.webView.stringByEvaluatingJavaScriptFromString("addGuest('" + guest.firstName! + "')")
            }
            
            self.webView.stringByEvaluatingJavaScriptFromString("showGuestConfirmedModal()")
            
            guestNames = nil
            
        }
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        print("failed")
    }
}


