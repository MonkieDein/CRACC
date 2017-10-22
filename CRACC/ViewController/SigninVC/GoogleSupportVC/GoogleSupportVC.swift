
//
//  GoogleSupportVC.swift
//  CRACC
//
//  Created by Khoi Nguyen on 10/22/17.
//  Copyright © 2017 Cracc LLC. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class GoogleSupportVC: UIViewController {

    
    
    
    
    var name: String?
    var gender: String?
    var type: String?
    var email: String?
    var avatarUrl: String?
    var birthday: String?
    
    @IBOutlet weak var birthdayTxtField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        birthdayTxtField.becomeFirstResponder()
        let datePickerView: UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        datePickerView.maximumDate = Date()
        //datePickerView.minimumDate = Date()
        //.addingTimeInterval(60 * 60 * 24 * 5)
        
        
        
        birthdayTxtField.inputView = datePickerView
        
        //datePickerView.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(GoogleSupportVC.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        birthdayTxtField.text = dateFormatter.string(from: sender.date)
        
        
        
        
        
        
    }
    
    @IBAction func signUpBtnPressed(_ sender: Any) {
        
        if let birthday = birthdayTxtField.text, birthday != "" {
            
            
            
            if let name = name, name != "", let email = email, email != "", let avatarUrl = avatarUrl, avatarUrl != "", let gender = gender, gender != "" {
            
                
                let profile: Dictionary<String, AnyObject> = ["Type": self.type as AnyObject,"Birthday": self.birthday as AnyObject, "Name": self.name as AnyObject, "Email": self.email as AnyObject, "Gender": self.gender! as AnyObject, "avatarUrl": avatarUrl as AnyObject, "Stars": 0 as AnyObject,"Timestamp": ServerValue.timestamp() as AnyObject]
                
                
                DataService.instance.UsersRef.child("Google").child(userUID).setValue(profile)
                DataService.instance.checkGoogleUserRef.child(userUID).setValue(["Timestamp": ServerValue.timestamp()])
                DataService.instance.mainDataBaseRef.child("User").child(userUID).child("Game Created").setValue(["defalut": "defaults"])
                DataService.instance.mainDataBaseRef.child("User").child(userUID).child("Game Joined").setValue(["defalut": "defaults"])
                DataService.instance.mainDataBaseRef.child("User").child(userUID).child("Chat List").setValue(["defalut": "defaults"])
                DataService.instance.mainDataBaseRef.child("User").child(userUID).child("Interested List").setValue(["defalut": "defaults"])
                DataService.instance.mainDataBaseRef.child("User").child(userUID).child("Community List").setValue(["defalut": "defaults"])
                
                
                
                view.endEditing(true)
                self.performSegue(withIdentifier: "moveToMapVC3", sender: nil)
            
            } else {
            
                showErrorAlert("Oops !!!", msg: "CRACC: error occured")
            
            
            }
            
            
        } else {
        
        
        showErrorAlert("Oops !!!", msg: "CRACC: Please choose your birthday")
        
        
        }
        
        
        
        
        
        
        
        
    }
    
    
    

    
    @IBAction func goBackBtnPressed(_ sender: Any) {
        
        
        self.dismiss(animated: true, completion: nil)
        
        
        
    }
    
    func showErrorAlert(_ title: String, msg: String) {
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        
        
        present(alert, animated: true, completion: nil)
        
    }

}
