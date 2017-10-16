//
//  signUpVC.swift
//  CRACC
//
//  Created by Khoi Nguyen on 10/15/17.
//  Copyright © 2017 Cracc LLC. All rights reserved.
//

import UIKit

class signUpVC: UIViewController {

    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var lastNameLbl: UITextField!
    @IBOutlet weak var firstNameLbl: UITextField!
    @IBOutlet weak var emailLbl: UITextField!
    @IBOutlet weak var birthdayLbl: UITextField!
    @IBOutlet weak var pwdLbl: UITextField!
    @IBOutlet weak var confirmPwdLbl: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func dismissBtnPressed(_ sender: Any) {
        
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    @IBAction func birthdayBtnPressed(_ sender: UITextField) {
        
        let datePickerView: UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        //datePickerView.maximumDate = Date().addingTimeInterval(60 * 60 * 24 * 5)
        //datePickerView.minimumDate = Date()
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(signUpVC.datePickerValueChanged), for: UIControlEvents.valueChanged)
        
        
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateTextField.text = dateFormatter.string(from: sender.date)
        
        
        
        
        
        
    }
    
    
    
    @IBAction func signUpBtnPressed(_ sender: Any) {
    }
    

}
