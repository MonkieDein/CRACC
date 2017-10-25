//
//  SettingVC.swift
//  CRACC
//
//  Created by Khoi Nguyen on 10/22/17.
//  Copyright © 2017 Cracc LLC. All rights reserved.
//

import UIKit
import Cache
import MobileCoreServices
import AVKit
import AVFoundation




class SettingVC: UIViewController, UINavigationControllerDelegate  {

    @IBOutlet weak var emailLbl: UITextField!
    @IBOutlet weak var lastNameLbl: UITextField!
    @IBOutlet weak var firstNameLbl: UITextField!
    @IBOutlet weak var profileImgView: ImageRound!
    
    
    var imageProfile: UIImage?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        
        
        
        
        if let CacheavatarImg = try? InformationStorage?.object(ofType: ImageWrapper.self, forKey: "avatarImg").image {
            
            self.profileImgView.image = CacheavatarImg
            
        }
        
        if let CachedName = try? InformationStorage?.object(ofType: String.self, forKey: "name"){
            
            let fullName = CachedName
            let fullNameArr : [String] = fullName!.components(separatedBy: " ")
            
            // And then to access the individual words:
            
            let firstName = fullNameArr[0]
            let temporarylastName = fullNameArr[1...fullNameArr.count - 1]
            
            let lastName = temporarylastName.joined(separator: " ")
            firstNameLbl.text = firstName
            lastNameLbl.text = lastName
            
        }
        
        if let CachedEmail = try? InformationStorage?.object(ofType: String.self, forKey: "email"){
            
            
            emailLbl.text = CachedEmail
            
            
        }
        
        
        
        
        
        
    }
    
    @IBAction func SetProfileImgBtnPressed(_ sender: Any) {
        
        self.getMediaFrom(kUTTypeImage as String)
        
    }
    
    func getImage(image: UIImage) {
        profileImgView.image = image
        imageProfile = image
    }
    
    
    // get media
    
    func getMediaFrom(_ type: String) {
        let mediaPicker = UIImagePickerController()
        mediaPicker.delegate = self
        mediaPicker.mediaTypes = [type as String]
        self.present(mediaPicker, animated: true, completion: nil)
    }
    
    
    @IBAction func backBtnPressed1(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
        
    }
    
    @IBAction func backBtnPressed2(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}

extension SettingVC: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let picture = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            getImage(image: picture)
            
        }
        view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
        
    }
}
