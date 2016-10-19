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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ScanDone"{
            let controller = segue.destinationViewController as! UINavigationController
            let viewController = controller.viewControllers.first as! ViewController
            viewController.urlString = sender as? String
        }
    }
    
    @IBOutlet weak var scanLineConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var containerHeihhtCons: NSLayoutConstraint!
    
    @IBOutlet weak var scanImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        previewLayer.addSublayer(drawlayer)
        
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
    
    //拿到输出对象
    private lazy var avcapOutput:AVCaptureMetadataOutput = AVCaptureMetadataOutput()
    
    //创建预览图层
    private lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        let layer = AVCaptureVideoPreviewLayer(session: self.session)
        layer.frame = UIScreen.mainScreen().bounds
        return layer
    }()
    
    private lazy var drawlayer: CALayer = {
        let layer = CALayer()
        layer.frame = UIScreen.mainScreen().bounds
        return layer
    }()
}


extension QRCodeViewController:AVCaptureMetadataOutputObjectsDelegate
{
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!)
    {
        //print(metadataObjects)
        clearlayer()
        //        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        //navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        //navigationItem.title = metadataObjects.last?.stringValue
        
        self.performSegueWithIdentifier("ScanDone", sender: metadataObjects.last?.stringValue)
        
        for object in metadataObjects{
            if object is AVMetadataMachineReadableCodeObject {
                let codeobject = previewLayer.transformedMetadataObjectForMetadataObject(object as! AVMetadataObject) as!AVMetadataMachineReadableCodeObject
                
                drawCorners(codeobject)
            }
        }
    }
    
    func drawCorners(codeobject:AVMetadataMachineReadableCodeObject)
    {
        let layer = CAShapeLayer()
        layer.lineWidth = 2
        layer.strokeColor = UIColor.greenColor().CGColor
        layer.fillColor = UIColor.clearColor().CGColor
        
        let path = UIBezierPath()
        var point = CGPointZero
        var index = 0
        
        CGPointMakeWithDictionaryRepresentation((codeobject.corners[index] as! CFDictionaryRef), &point)
        path.moveToPoint(point)
        
        index += 1
        
        while index < codeobject.corners.count {
            
            
            CGPointMakeWithDictionaryRepresentation((codeobject.corners[index] as! CFDictionaryRef), &point)
            path.addLineToPoint(point)
            
            index += 1
        }
        
        path.closePath()
        
        layer.path = path.CGPath
        
        drawlayer.addSublayer(layer)
    }
    
    func clearlayer()
    {
        if drawlayer.sublayers == nil || drawlayer.sublayers?.count == 0 {
            return
        }
        
        for subLayer in drawlayer.sublayers! {
            subLayer.removeFromSuperlayer()
        }
    }
}