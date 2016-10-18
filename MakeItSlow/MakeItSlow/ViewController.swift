//
//  ViewController.swift
//  MakeItSlow
//
//  Created by Tyreal Gray on 10/18/16.
//  Copyright © 2016 Tyreal Gray. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    var wk:WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.wk = WKWebView(frame: self.view.frame)
        self.wk.load(NSURLRequest(url: NSURL(string: "http://www.baidu.com/")! as URL) as URLRequest)
        self.view.addSubview(self.wk)
    }


}

