//
//  FirstLookVC.swift
//  CRACC
//
//  Created by Khoi Nguyen on 10/7/17.
//  Copyright © 2017 Cracc LLC. All rights reserved.
//

import UIKit

class FirstLookVC: UIViewController {

    @IBOutlet weak var width2Constraint: NSLayoutConstraint!
    
    @IBOutlet weak var width1Constraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        width1Constraint.constant = self.view.frame.width *
        (100/414)
        width2Constraint.constant = self.view.frame.width * (100/414)


        
    }
    @IBAction func loginWithEmailBtnPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "MoveToMapVC", sender: nil)
    }
    
    @IBAction func FaceBookBtnPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "MoveToMapVC", sender: nil)
        
    }
    
    @IBAction func GoogleBtnPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "MoveToMapVC", sender: nil)
    }
    
}
