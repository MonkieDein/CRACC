//
//  signUpVC2.swift
//  CRACC
//
//  Created by Khoi Nguyen on 10/22/17.
//  Copyright © 2017 Cracc LLC. All rights reserved.
//

import UIKit

class signUpVC2: UIViewController {

    @IBOutlet weak var maleBtn: RoundedBtn!
    @IBOutlet weak var femaleBtn: RoundedBtn!
    @IBOutlet weak var birthdayTxtField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
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
        
        datePickerView.addTarget(self, action: #selector(signUpVC2.datePickerValueChanged), for: UIControlEvents.valueChanged)
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
        
        
        view.endEditing(true)
        
        
        
    }
   
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        birthdayTxtField.text = dateFormatter.string(from: sender.date)
        
        
        
        
        
        
    }
    
    
    
    
    
    
    @IBAction func NextBtnPressed(_ sender: Any) {
        
        self.performSegue(withIdentifier: "moveToSignUpVC3", sender: nil)
        
        
    }
    
    
    
    @IBAction func backBtnPressed(_ sender: Any) {
        view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func maleBtnPressed(_ sender: Any) {
        
        
    
        
        
    }
    @IBAction func femaleBtnPressed(_ sender: Any) {
        
        
        
        
        
    }
    
}
