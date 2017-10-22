//
//  cameraVC.swift
//  CRACC
//
//  Created by Khoi Nguyen on 10/16/17.
//  Copyright © 2017 Cracc LLC. All rights reserved.
//

import UIKit
import CameraManager

class cameraVC: UIViewController {

    @IBOutlet weak var cameraView: UIView!
    
    var orientation = ""
    
    let cameraManager = CameraManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // load first orientation
        
        orientation = "front"
        
        // ask for permission camera user
        cameraManager.showAccessPermissionPopupAutomatically = true
        // set default output
        cameraManager.cameraOutputMode = .videoWithMic
        
        
        // check camera condition and use
        
        let currentCameraState = cameraManager.currentCameraStatus()
        
        
        if currentCameraState == .notDetermined {
            
            askForPermission()
            
        } else {
            addCameraToView()
        }
        
        cameraManager.flashMode = .auto
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cameraManager.resumeCaptureSession()
    }
    
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // stop camera session
        cameraManager.stopCaptureSession()
    }
    
    
    
    // private func add camera to view
    
    fileprivate func addCameraToView()
        
        
    {
        
        cameraManager.cameraDevice = .front
        
        
        // camera camera view
        _ = cameraManager.addPreviewLayerToView(cameraView)
        cameraManager.showErrorBlock = { [weak self] (erTitle: String, erMessage: String) -> Void in
            
            let alertController = UIAlertController(title: erTitle, message: erMessage, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (alertAction) -> Void in  }))
            
            self?.present(alertController, animated: true, completion: nil)
        }
    }
    
    // ask for permission for the first time
    
    fileprivate func askForPermission() {
        cameraManager.askUserForCameraPermission({ permissionGranted in
            if permissionGranted {
                self.addCameraToView()
            }
        })
    }

    @IBAction func changeScreenBtnPressed(_ sender: Any) {
        cameraManager.cameraDevice = cameraManager.cameraDevice == CameraDevice.front ? CameraDevice.back : CameraDevice.front
        switch (cameraManager.cameraDevice) {
        case .front:
            print("front")
            orientation = "front"
        case .back:
            print("back")
            orientation = "back"
        }
    }
    
    @IBAction func recordBtnPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
