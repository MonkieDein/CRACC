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
        
        
        
        
    }
    
    
    
}
