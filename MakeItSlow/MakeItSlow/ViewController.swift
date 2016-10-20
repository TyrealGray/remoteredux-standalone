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
    
    var urlString:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if ((urlString) != nil){
            
            let webview = self.embeddedViewController as WebViewController
            webview.goUrl(urlString!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    private weak var embeddedViewController: WebViewController!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let wvvc = segue.destinationViewController as? WebViewController
            where segue.identifier == "EmbedWebView" {
            
            self.embeddedViewController = wvvc
        }
    }

}


