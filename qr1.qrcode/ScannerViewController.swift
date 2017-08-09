//
//  ViewController.swift
//  qr1.qrcode
//
//  Created by Bahaeddin Sagar on 7/25/17.
//  Copyright © 2017 Almadar Aljadid. All rights reserved.
//

import AVFoundation
import UIKit
import Permission


class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    var tourch = UIBarButtonItem(image : #imageLiteral(resourceName: "flash_on"), style : .plain, target: self, action: #selector(toggleFlash))
    
    
    
    
    @IBOutlet var CameraView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let permission: Permission = .camera
        // chnange titles to Arabic (denied)
        permission.deniedAlert.title    = "الرجاء السماح للبرنامج الوصول الى الكاميرا"
        permission.deniedAlert.message  = "لقراءة الكود "
        permission.deniedAlert.cancel   = "لا"
        permission.deniedAlert.settings = "الاعدادات"
        // chnange titles to Arabic (PrePermission)
        permission.prePermissionAlert.title   = "الرجاء السماح للبرنامج الوصول الى الكاميرا"
        permission.prePermissionAlert.message = "لقراءة الكود "
        permission.prePermissionAlert.cancel  = "ليس الأن"
        permission.prePermissionAlert.confirm = "حسنا"
        
        
        
        permission.request { status in
            switch status {
            case .authorized:
                print("authorized")
                break
            case .denied:
                print("denied")
                
                
                _ = permission.deniedAlert // or permission.disabledAlert
                
            case .disabled:
                print("disabled")
                _ = permission.deniedAlert // or permission.disabledAlert
                
                
                
            case .notDetermined:
                print("not determined")
                permission.presentPrePermissionAlert = true
                
                _ = permission.prePermissionAlert
                
                
            }
        }
        
        
        
        
        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()
        
        let videoCaptureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed();
            return;
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        } else {
            failed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession);
        
        previewLayer.frame = CameraView.layer.bounds;
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        view.layer.addSublayer(previewLayer);
        
        captureSession.startRunning();
    }
    
    func failed() {
        
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        
        captureSession = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession?.isRunning == false) {
            captureSession.startRunning();
        }
        
        self.navigationController?.title = " مسح الكود "
        
        self.navigationItem.rightBarButtonItem = tourch
        
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning();
        }
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            let readableObject = metadataObject as! AVMetadataMachineReadableCodeObject;
            
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: readableObject.stringValue);
        }
        
        dismiss(animated: true)
    }
    
    func found(code: String) {
        
        
        let myVC = storyboard?.instantiateViewController(withIdentifier: "Result") as! ResultViewController
        myVC.scanResult = code
        navigationController?.pushViewController(myVC, animated: true)
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    
    
    
    func toggleFlash() {
        let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)!
        if (device.hasTorch) {
            do {
                try device.lockForConfiguration()
                if (device.torchMode == AVCaptureTorchMode.on) {
                    device.torchMode = AVCaptureTorchMode.off
                    
                    tourch.image = #imageLiteral(resourceName: "flash_on")
                    
                } else {
                    do {
                        try device.setTorchModeOnWithLevel(1.0)
                        tourch.image = #imageLiteral(resourceName: "flash_off")
                        
                    } catch {
                        print(error)
                    }
                }
                device.unlockForConfiguration()
            } catch {
                print(error)
            }
        }
    }
    
    
    
}
