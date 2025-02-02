//
//  ScannerViewController.swift
//  Barcode
//
//  Created by Osman Balci on 2/11/24.
//  Copyright © 2024 Osman Balci. All rights reserved.
//

import UIKit
import AVFoundation

/*
 ----------------------------------------------------------------------------
 SwiftUI framework does not yet directly support barcode scanning. Therefore,
 we do it by using UIKit's UIViewController class, which is wrapped by the
 BarcodeScanner struct in BarcodeScanner.swift to interface with SwiftUI.
 ----------------------------------------------------------------------------
 */
class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var delegate: AVCaptureMetadataOutputObjectsDelegate!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = UIColor.gray
        captureSession = AVCaptureSession()

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }

        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }

        let metadataOutput = AVCaptureMetadataOutput()
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(delegate, queue: DispatchQueue.main)
            /*
             ----------------------------------------------------------------------------------
             See listing of all metadata object types (barcode types) at
             https://developer.apple.com/documentation/avfoundation/avmetadataobject/objecttype
             .qr    Quick Response (QR) barcode reading
             List the barcode types here for your app to be able to read.
             ----------------------------------------------------------------------------------
             */
            metadataOutput.metadataObjectTypes = [.code128, .pdf417, .aztec, .qr, .ean8, .ean13, .upce]
        } else {
            failed()
            return
        }
        
        // Set the view to the camera preview of the capture session
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)

        captureSession.startRunning()
    }

    // Inform user about the failure
    func failed() {
        let alertController = UIAlertController(title: "Your Device does not Support Scanning!",
                                                message: "Please use a device that supports scanning!",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
        captureSession = nil
    }

    // Start the capture session if it is not running before the view appears
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }

    // End the capture session if it is running before the view disappears
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }

    // Hide the status bar for scanning
    override var prefersStatusBarHidden: Bool {
        return true
    }

    // Support only portrait device orientation for scanning
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}


