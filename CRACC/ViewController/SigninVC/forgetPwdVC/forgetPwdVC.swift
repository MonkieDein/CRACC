//
//  forgetPwdVC.swift
//  CRACC
//
//  Created by Khoi Nguyen on 10/15/17.
//  Copyright © 2017 Cracc LLC. All rights reserved.
//

import UIKit

class forgetPwdVC: UIViewController {

    @IBOutlet weak var ResetEmailPwdLbl: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func dismissBtnPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func sendCodeBtnPressed(_ sender: Any) {
        
        if let email = ResetEmailPwdLbl.text, email != "" {
            
        } else {
            
            showErrorAlert("Oops !!!", msg: "CRACC: Fill your email and we will help you to reset your account.")
            
            
        }
        
        
        
        
    }
    
    // func show error alert
    
    func showErrorAlert(_ title: String, msg: String) {
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
}
