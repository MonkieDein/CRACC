//
//  FirstLookVC.swift
//  CRACC
//
//  Created by Khoi Nguyen on 10/7/17.
//  Copyright © 2017 Cracc LLC. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import FirebaseAuth
import Google


class FirstLookVC: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var pwdTextField: UITextField!
    
    @IBOutlet weak var width2Constraint: NSLayoutConstraint!
    
    @IBOutlet weak var width1Constraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //width1Constraint.constant = self.view.frame.width *
        //(100/414)
        //width2Constraint.constant = self.view.frame.width * (100/414)
    
        
        
        
        //error object
        var error : NSError?
        
        //setting the error
        GGLContext.sharedInstance().configureWithError(&error)
        
        //if any error stop execution and print error
        if error != nil{
            print(error ?? "google error")
            return
        }
        
        //adding the delegates
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
        

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        //adding the delegates
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
    }
 
    
    //when the signin complets
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        //if any error stop and print the error
        if error != nil{
            print(error ?? "google error")
            return
        }
        
        print(user.profile.imageURL(withDimension: 500))
        
        
    }
    
    
    
    @IBAction func loginWithEmailBtnPressed(_ sender: Any) {
        
        
        if let email = emailTextField.text, email != "", let pwd = pwdTextField.text, pwd != "" {
            
            
            self.performSegue(withIdentifier: "MoveToMapVC", sender: nil)
            
        } else {
            
            
            
            
        }
        
        
        
        
    }
    
    @IBAction func FaceBookBtnPressed(_ sender: Any) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("JESS: Unable to authenticate with Facebook - \(String(describing: error))")
            } else if result?.isCancelled == true {
                print("JESS: User cancelled Facebook authentication")
            } else {
                print("JESS: Successfully authenticated with Facebook")
                //let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                //self.firebaseAuth(credential)
            
                FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, email,age_range, picture.type(large)"]).start(completionHandler: { (connection, result, error) -> Void in
                    if (error == nil){
                        let fbDetails = result as! NSDictionary
                        print(fbDetails)
                        self.getFriendList()
                    }else{
                        print(error?.localizedDescription ?? "Not found")
                    }
                    
                })
                
                
                
                
                
                
            }
        }
        
        
    }
    
    
    func getFriendList() {
        let params = ["fields": "id, first_name, last_name, name, email, picture"]
        
        let graphRequest = FBSDKGraphRequest(graphPath: "/me/friends", parameters: params)
        let connection = FBSDKGraphRequestConnection()
        connection.add(graphRequest, completionHandler: { (connection, result, error) in
            if error == nil {
                if let userData = result as? [String:Any] {
                    print(userData)
                }
            } else {
                print("Error Getting Friends \(String(describing: error))");
            }
            
        })
        
        connection.start()
    }
    
    
    func firebaseAuth(_ credential: AuthCredential) {
    
        
    }
    
    
    @IBAction func GoogleBtnPressed(_ sender: Any) {
       
        
        
         GIDSignIn.sharedInstance().signIn()
        
    
    }
    
    
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func moveToNewAccountBtnPressed(_ sender: Any) {
        
        
        self.performSegue(withIdentifier: "moveToSignUpVC", sender: nil)
        
        
    }
    
    @IBAction func moveToForgetPwdVC(_ sender: Any) {
        
        self.performSegue(withIdentifier: "moveToForgetPwdVC", sender: nil)
    }
    
}
