//
//  ViewController.swift
//  CRACC
//
//  Created by Khoi Nguyen on 9/30/17.
//  Copyright © 2017 Cracc LLC. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Firebase
import FirebaseDatabase
import CameraManager


class MapVC: UIViewController, GMSMapViewDelegate {
    
    // setup orientation for camera
    
    var orientation: String!
    
    let cameraManager = CameraManager()
    
    @IBOutlet weak var cameraView: UIView!
    var Done = true
    
    
    @IBOutlet weak var bottomHeight: NSLayoutConstraint!
    
    // create game view
    
    @IBOutlet weak var createGameViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var createGameView: ModifiedInformationView!
    
    // list btn of ProfileView
    
    @IBOutlet weak var createNewGameBtn2: UIButton!
    @IBOutlet weak var InformationBtn2: UIButton!
    @IBOutlet weak var InterestedBtn2: UIButton!
    @IBOutlet weak var communityBtn2: UIButton!
    @IBOutlet weak var logoutBtn2: UIButton!
    
    
    // constraint for chatView
    
    @IBOutlet weak var bottomConstraintForChatView: NSLayoutConstraint!
    @IBOutlet weak var leadingConstraintForChatView: NSLayoutConstraint!
    
    var CreateGameTop = 0
    @IBOutlet weak var profileBtn: RoundBtn!
    
    
    
    
    
    
    
    @IBOutlet weak var InformationView: ModifiedInformationView!
    
    
    
    
    
    
    
    @IBOutlet weak var profileView: UIView!
    
    @IBOutlet weak var controlGameView: Modified2cornerView!
    @IBOutlet weak var heightOfControlGameView2: NSLayoutConstraint!
    @IBOutlet weak var heightOfControlGameView: NSLayoutConstraint!
    @IBOutlet weak var locationBtn: RoundBtn!
    @IBOutlet weak var chatView: UIView!
    @IBOutlet weak var navigationVC: UIView!
    @IBOutlet weak var mapView: GMSMapView!
    var locationManager = CLLocationManager()
    let authorizationStatus = CLLocationManager.authorizationStatus()
    
    @IBOutlet weak var chatViewLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var chatImage: UIButton!
    
    @IBOutlet weak var GameManagementImage: UIButton!
    
    //@IBOutlet weak var heightOfDetailView: NSLayoutConstraint!
    
    @IBOutlet weak var widthJoinBtn: NSLayoutConstraint!
    
    @IBOutlet weak var heightJoinBtn: NSLayoutConstraint!
    var marker = GMSMarker()
    @objc var tapToUndo: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // setting content allignment of list button in profile view
        SetContentAllignmenttoBtn()
        
        heightOfControlGameView.constant = self.view.frame.height * (359/736) + 30
        
        leadingConstraintForChatView.constant = self.view.frame.width * (1/2)
        bottomConstraintForChatView.constant = self.view.frame.height * (1/2) - 75
        
        
        // declare self for all delegate function
        mapView.delegate = self
        locationManager.delegate = self
        configureLocationServices()
        
        
        //blurMap()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MapVC.showKeyBoard), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MapVC.hideKeyboard), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    
    @objc func showKeyBoard(noftification: NSNotification) {
        
        if let userInfo = noftification.userInfo {
            if let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                CreateGameTop = Int(createGameViewTopConstraint.constant)
                createGameViewTopConstraint.constant = -67.0
                bottomHeight.constant = keyboardSize.height - 40.0
                Done = false
                view.setNeedsLayout()

                
            }
        }
    }
    
    
    
    @objc func hideKeyboard(noftification: NSNotification) {
        bottomHeight.constant = 1.0
        createGameViewTopConstraint.constant = CGFloat(CreateGameTop)
        Done = true
        view.setNeedsLayout()
    }

    func configureLocationService() {
        
        centerMapOnUserLocation()
    }
    
    // game management button setup
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    @IBAction func GameMangeBtnPressed(_ sender: Any) {
        
        if let container = self.so_containerViewController {
            container.isSideViewControllerPresented = true
        }
    
        
    }
    
    
    func SetContentAllignmenttoBtn() {
        createNewGameBtn2.contentHorizontalAlignment = .left
        InformationBtn2.contentHorizontalAlignment = .left
        InterestedBtn2.contentHorizontalAlignment = .left
        communityBtn2.contentHorizontalAlignment = .left
        logoutBtn2.contentHorizontalAlignment = .left
    }
/*
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
    }
 */
    
    // setup camera
    
    func setupCamera() {
    
        // load first orientation
        
        orientation = "front"
        
        // ask for permission camera user
        cameraManager.showAccessPermissionPopupAutomatically = true
        // set default output
        cameraManager.cameraOutputMode = .stillImage
        
        
        // check camera condition and use
        
        let currentCameraState = cameraManager.currentCameraStatus()
        
        
        if currentCameraState == .notDetermined {
            
            askForPermission()
            
        } else {
            addCameraToView()
        }
        
        cameraManager.flashMode = .auto
    
    
    
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
    
    
    
    // chat button setup
    
    @IBAction func chatBtnPressed(_ sender: Any) {
        
        
        chatView.isHidden =  false
        
        blurMap()
        freezeTheMapActivity()
        
        // add gesture to close when necessary
        
        tapToUndo = UITapGestureRecognizer(target: self, action: #selector(MapVC.UndoTheMainMapActivity))
        self.view.addGestureRecognizer(tapToUndo)
    }
    
    func blurMap() {
        
        
        self.mapView.backgroundColor = UIColor.darkGray
        self.mapView.alpha = 0.4
        self.navigationVC.alpha = 0.4
        self.locationBtn.alpha = 0.4
        
        
        
    }
    
    func freezeTheMapActivity() {
        
        
        self.mapView.isUserInteractionEnabled = false
        self.locationBtn.isUserInteractionEnabled = false
        self.chatImage.isUserInteractionEnabled = false
        self.GameManagementImage.isUserInteractionEnabled = false
        self.profileBtn.isUserInteractionEnabled = false
        
        // hold the open
        
        
        
        
    }
    
    @objc func UndoTheMainMapActivity() {
        
        if Done == true {
            self.mapView.isUserInteractionEnabled = true
            self.locationBtn.isUserInteractionEnabled = true
            self.chatImage.isUserInteractionEnabled = true
            self.GameManagementImage.isUserInteractionEnabled = true
            self.profileBtn.isUserInteractionEnabled = true
            
            // undo blur
            
            self.mapView.backgroundColor = UIColor.clear
            self.mapView.alpha = 1.0
            self.navigationVC.alpha = 1.0
            self.locationBtn.alpha = 1.0
            
            // hide unecessaryView
            profileView.isHidden =  true
            chatView.isHidden = true
            InformationView.isHidden = true
            controlGameView.isHidden = true
            createGameView.isHidden = true
            
            // remove gesture
            
            self.view.removeGestureRecognizer(tapToUndo)
            // stop camera session
            cameraManager.stopCaptureSession()
        }
        
        view.endEditing(true)
        
        
        
    }
        
    @IBAction func openCameraVC(_ sender: Any) {
        
        
        self.performSegue(withIdentifier: "moveToCamersVC", sender: nil)
        
    
        
        
        
    }
    
        
    @IBAction func SettingBtnPressed(_ sender: Any) {
        profileView.isHidden =  false
     
        blurMap()
        freezeTheMapActivity()
        // add gesture to close when necessary
        
        tapToUndo = UITapGestureRecognizer(target: self, action: #selector(MapVC.UndoTheMainMapActivity))
        self.view.addGestureRecognizer(tapToUndo)
        
        
        
        
    }
    
    @IBAction func CenterMyLocation(_ sender: Any) {
        centerMapOnUserLocation()
    }
    // Profile setting btn
    @IBAction func createNewGameBtnPressed(_ sender: Any) {
        
        profileView.isHidden = true
        createGameView.isHidden =  false
        setupCamera()
        cameraManager.resumeCaptureSession()
        blurMap()
        freezeTheMapActivity()
        // add gesture to close when necessary
        
        tapToUndo = UITapGestureRecognizer(target: self, action: #selector(MapVC.UndoTheMainMapActivity))
        self.view.addGestureRecognizer(tapToUndo)
        
    }
    @IBAction func createNewGameBtn2Pressed(_ sender: Any) {
        
        
        profileView.isHidden = true
        createGameView.isHidden =  false
        setupCamera()
        cameraManager.resumeCaptureSession()
        blurMap()
        freezeTheMapActivity()
        // add gesture to close when necessary
        
        tapToUndo = UITapGestureRecognizer(target: self, action: #selector(MapVC.UndoTheMainMapActivity))
        self.view.addGestureRecognizer(tapToUndo)
        
        
    }
    
    @IBAction func InfomationBtnPressed(_ sender: Any) {
        
        
        profileView.isHidden = true
        InformationView.isHidden =  false
        
        blurMap()
        freezeTheMapActivity()
        // add gesture to close when necessary
        
        tapToUndo = UITapGestureRecognizer(target: self, action: #selector(MapVC.UndoTheMainMapActivity))
        self.view.addGestureRecognizer(tapToUndo)
        
    }
    @IBAction func InterestedBtnPressed(_ sender: Any) {
        
        
        self.performSegue(withIdentifier: "moveToInterestedVC", sender: nil)
        
    }
    @IBAction func InterestedBtn2Pressed(_ sender: Any) {
        
        self.performSegue(withIdentifier: "moveToInterestedVC", sender: nil)
        
    }
    @IBAction func communityBtnPressed(_ sender: Any) {
        
        self.performSegue(withIdentifier: "goToCommunityVC", sender: nil)
    }
    
    @IBAction func communityBtn2Pressed(_ sender: Any) {
        
        self.performSegue(withIdentifier: "goToCommunityVC", sender: nil)

    }
    
    
    @IBAction func information2Btnpressed(_ sender: Any) {
        
        profileView.isHidden = true
        InformationView.isHidden =  false
        
        blurMap()
        freezeTheMapActivity()
        // add gesture to close when necessary
        
        tapToUndo = UITapGestureRecognizer(target: self, action: #selector(MapVC.UndoTheMainMapActivity))
        self.view.addGestureRecognizer(tapToUndo)
        
        
    }
    
    @IBAction func logOutBtnPressed(_ sender: Any) {
        
        self.performSegue(withIdentifier: "GoBackToSignInVC", sender: nil)
        
    }
    @IBAction func logOutBtn2Pressed(_ sender: Any) {
        
        self.performSegue(withIdentifier: "GoBackToSignInVC", sender: nil)
    }
}
extension MapVC  {
    func centerMapOnUserLocation() {
        // get coordinate
        guard let coordinate = locationManager.location?.coordinate else { return }
        
        // get MapView
        let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 12)
        
        mapView.animate(to: camera)
       
        
        // setup marker
        marker.isFlat = true
        marker.map = mapView
        if marker.map != nil {
            
            marker.map = nil
            
        }
            
        marker.position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        marker.title = "My Location"
        var IconImage = UIImage(named: "direction")
        // check if Image not nil
        guard IconImage != nil else {
            return
        }
        // resize image to 30-32
        IconImage = resizeImage(image: IconImage!, targetSize: CGSize(width: 28.0, height: 30.0))
        // setup marker icon
        marker.icon = IconImage
        //marker.appearAnimation
        marker.map = mapView
        
        
        
    }
    
}

    
    
extension MapVC: CLLocationManagerDelegate {
    // check if auth is not nil then request auth
    func configureLocationServices() {
        if authorizationStatus == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        } else {
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // get my location with zoom 30
        centerMapOnUserLocation()
    }
}

