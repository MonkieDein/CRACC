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


class MapVC: UIViewController, GMSMapViewDelegate {
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
        
        heightOfControlGameView.constant = self.view.frame.height * (359/736) + 30
        //heightOfControlGameView2.constant = self.controlGameView.frame.height * (100/359)
        
        //let newHeight = heightOfControlGameView.constant
        //print(self.view.frame.height * (359/736))
        //print(heightOfControlGameView.constant)
        //print(self.controlGameView.frame.height)
        //print(newHeight)
        
        //heightOfDetailView.constant = newHeight * (143/359)
        
        //widthJoinBtn.constant = self.view.frame.width * (158/320)
        //heightOfDetailView.constant = self.view.frame.height * (48/568)
        
        
        
        // declare self for all delegate function
        mapView.delegate = self
        locationManager.delegate = self
        configureLocationServices()
        
        marker.tracksInfoWindowChanges = true
        blurMap()
        
        // Do any additional setup after loading the view, typically from a nib.
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
/*
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
    }
 */
    
    
    
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
        self.mapView.alpha = 0.3
        self.navigationVC.alpha = 0.3
        self.locationBtn.alpha = 0.3
        
        
        
    }
    
    func freezeTheMapActivity() {
        
        
        self.mapView.isUserInteractionEnabled = false
        self.locationBtn.isUserInteractionEnabled = false
        self.chatImage.isUserInteractionEnabled = false
        self.GameManagementImage.isUserInteractionEnabled = false
        
        // hold the open
        
        
        
        
    }
    
    @objc func UndoTheMainMapActivity() {
        
        
        self.mapView.isUserInteractionEnabled = true
        self.locationBtn.isUserInteractionEnabled = true
        self.chatImage.isUserInteractionEnabled = true
        self.GameManagementImage.isUserInteractionEnabled = true
        
        // undo blur
        
        self.mapView.backgroundColor = UIColor.clear
        self.mapView.alpha = 1.0
        self.navigationVC.alpha = 1.0
        self.locationBtn.alpha = 1.0
        
        // hide unecessaryView
         profileView.isHidden =  true
         chatView.isHidden = true
        
        // remove gesture
        
        self.view.removeGestureRecognizer(tapToUndo)
        
        
        
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
        
        
    }
    
    @IBAction func InfomationBtnPressed(_ sender: Any) {
        
        
    }
    @IBAction func InterestedBtnPressed(_ sender: Any) {
        
        
        
        
    }
    @IBAction func communityBtnPressed(_ sender: Any) {
        
        self.performSegue(withIdentifier: "goToCommunityVC", sender: nil)
    }
    @IBAction func logOutBtnPressed(_ sender: Any) {
        
        
        
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
        IconImage = resizeImage(image: IconImage!, targetSize: CGSize(width: 30.0, height: 32.0))
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

