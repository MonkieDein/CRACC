//
//  signUpVC.swift
//  CRACC
//
//  Created by Khoi Nguyen on 10/15/17.
//  Copyright © 2017 Cracc LLC. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVKit
import AVFoundation
import Firebase

class signUpVC: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var profileImgView: ImageRound!
    
    @IBOutlet weak var profilePhoto: RoundBtn!
    @IBOutlet weak var lastNameLbl: UITextField!
    @IBOutlet weak var firstNameLbl: UITextField!
    
    var imageProfile: UIImage?
    
    
    @IBOutlet weak var constraintHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //firstNameLbl.becomeFirstResponder()
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
       // NotificationCenter.default.addObserver(self, selector: #selector(signUpVC.showKeyBoard), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
      //  NotificationCenter.default.addObserver(self, selector: #selector(signUpVC.hideKeyboard), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        firstNameLbl.becomeFirstResponder()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
        
        
        view.endEditing(true)
        
        
        
    }
    
    @objc func showKeyBoard(noftification: NSNotification) {
        
        if let userInfo = noftification.userInfo {
            if let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                constraintHeight.constant = keyboardSize.height + 20
                view.setNeedsLayout()
                
                
            }
        }
    }
    
    
    
    @objc func hideKeyboard(noftification: NSNotification) {
        constraintHeight.constant = 4.0
        view.setNeedsLayout()
    }

    
    @IBAction func dismissBtnPressed(_ sender: Any) {
        
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func signUpBtnPressed(_ sender: Any) {
        
        
        if let firstName = firstNameLbl.text, firstName != "", let lastName = lastNameLbl.text, lastName != "" {
            
            self.performSegue(withIdentifier: "moveToSignUpVC2", sender: nil)
            
            
            
        } else {
            
            self.showErrorAlert("Oops !!!", msg: "CRACC: Please fill out all the field for sign up.")
            
            
            
        }
        
        
        
    }
    
    
    // func show error alert
    
    func showErrorAlert(_ title: String, msg: String) {
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        
        
        present(alert, animated: true, completion: nil)
        
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
    
}


extension signUpVC: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let picture = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            getImage(image: picture)
            
        }
        view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
        
    }
}
