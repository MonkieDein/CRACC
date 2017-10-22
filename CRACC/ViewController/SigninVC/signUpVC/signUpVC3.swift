
//
//  signUpVC3.swift
//  CRACC
//
//  Created by Khoi Nguyen on 10/22/17.
//  Copyright © 2017 Cracc LLC. All rights reserved.
//

import UIKit

class signUpVC3: UIViewController {

    @IBOutlet weak var emailTxtField: UITextField!
    
    @IBOutlet weak var pwdTextField: UITextField!
    
    @IBOutlet weak var confirmedPwdTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        emailTxtField.becomeFirstResponder()
        
        
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.endEditing(true)
        
        
        
    }

    
    @IBAction func signUpBtnPressed(_ sender: Any) {
        
        self.performSegue(withIdentifier: "moveToMapVC2", sender: nil)
        
        
        
        
    }
    @IBAction func backBtnPressed(_ sender: Any) {
        
        view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
        
    }
    
}


