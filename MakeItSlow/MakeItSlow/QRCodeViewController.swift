//
//  File.swift
//  MakeItSlow
//
//  Created by Tyreal Gray on 10/19/16.
//  Copyright © 2016 Tyreal Gray. All rights reserved.
//

import UIKit
import AVFoundation


class QRCodeViewController: UIViewController {
    
    @IBOutlet weak var scanLineConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var containerHeihhtCons: NSLayoutConstraint!
    
    @IBOutlet weak var scanImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        startAnimation()
        
        startScan()
    }
    
    func startAnimation() {
        scanLineConstraint.constant = -containerHeihhtCons.constant
        scanImageView.layoutIfNeeded()
        
        UIView.animateWithDuration(2.0) { () -> Void in
            self.scanLineConstraint.constant = self.containerHeihhtCons.constant
            UIView.setAnimationRepeatCount(MAXFLOAT)
            self.scanImageView.layoutIfNeeded()
        }
    }
    
    func startScan() {
        
        if !session.canAddInput(avcapInput) || !session.canAddOutput(avcapOutput){
            return
        }
        
        session.addInput(avcapInput)
        session.addOutput(avcapOutput)
        
        avcapOutput.metadataObjectTypes = avcapOutput.availableMetadataObjectTypes
        
        //这个是只可读的
        avcapOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        
        view.layer.insertSublayer(previewLayer, atIndex: 0)
        
        //previewLayer.addSublayer(drawlayer)
        
        session.startRunning()
        
    }
    //会话
    private lazy var session:AVCaptureSession = {
        let session = AVCaptureSession()
        return session
    }()
    
    //拿到输入设备
    private lazy var avcapInput:AVCaptureDeviceInput? = {
        // 获取摄像头
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        do{
            // 创建输入对象
            let avcapOut = try AVCaptureDeviceInput(device: device)
            
            return avcapOut
        }catch{
            print(error)
            return nil
        }
    }()
    
    private lazy var avcapOutput:AVCaptureMetadataOutput = AVCaptureMetadataOutput()
    
    private lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        let layer = AVCaptureVideoPreviewLayer(session: self.session)
        layer.frame = UIScreen.mainScreen().bounds
        return layer
    }()
    
//    private lazy var drawlayer: CALayer = {
//        let layer = CALayer()
//        layer.frame = UIScreen.mainScreen().bounds
//        return layer
//    }()
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "ScanDone"{
            let controller = segue.destinationViewController as! UINavigationController
            let viewController = controller.viewControllers.first as! ViewController
            if let urlStr = sender as? String{
                viewController.setUrlTo(urlStr)
            }
            
        }
    }
}


extension QRCodeViewController:AVCaptureMetadataOutputObjectsDelegate
{
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!)
    {
        //print(metadataObjects)
        self.performSegueWithIdentifier("ScanDone", sender: metadataObjects.last?.stringValue)
        session.stopRunning()
    }
    
}