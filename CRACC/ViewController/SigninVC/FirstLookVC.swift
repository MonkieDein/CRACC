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
import Alamofire
import AlamofireImage
import SwiftLoader


//import GoogleSignIn

//import FirebaseFirestore


class FirstLookVC: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    
    
    // tap to dismiss keyboard
    var tap: UITapGestureRecognizer!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var pwdTextField: UITextField!
    
    @IBOutlet weak var width2Constraint: NSLayoutConstraint!
    
    @IBOutlet weak var width1Constraint: NSLayoutConstraint!
    
    
    
    
    var name: String?
    var birthday: String?
    var email: String?
    var avatarUrl: String?
    var type: String?
    var gender: String?
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    
         
        
        
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
        super.viewDidAppear(animated)
        
        //adding the delegates
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
         HideKeyboardWhenTapGesture()
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
    self.view.removeGestureRecognizer(tap)
        self.view.endEditing(true)
        
        
    }
    
    func HideKeyboardWhenTapGesture() {
        tap = UITapGestureRecognizer(target: self, action: #selector(FirstLookVC.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
 
    
    //when the signin complets
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        //if any error stop and print the error
        if error != nil{
            self.showErrorAlert("Oops!!!", msg: "CRACC: Unable to authenticate with Firebase - \(String(describing: error))")
            return
        }
        
        self.swiftLoader()
        let profile = user.profile
        let tokenAccess = user.authentication.accessToken
        let tokenID = user.authentication.idToken
        
        
        
        
        let credential = GoogleAuthProvider.credential(withIDToken: tokenID!,
                                                       accessToken: tokenAccess!)
        
        
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error {
                // ...
                self.showErrorAlert("Oops!!!", msg: "CRACC: Unable to authenticate with Firebase - \(String(describing: error))")
                return

            } else {
                if let user = user {
                    userUID = user.uid
                    DataService.instance.checkGoogleUserRef.child(userUID).observeSingleEvent(of: .value, with: { (snapShot) in
                        
                        if snapShot.value is NSNull {
                            let Url_Base = "https://www.googleapis.com/oauth2/v3/userinfo?access_token="
                            let _UrlProfile = "\(Url_Base)\(tokenAccess!)"
                            Alamofire.request(_UrlProfile).responseJSON { (response) in
                                
                                
                                switch response.result {
                                case .success:
                                    if let result = response.result.value as? [String: Any] {
                                        
                                        if let genders = result["gender"] {
                                            
                                            self.gender = genders as? String
                                            
                                            
                                        }
                                        
                                        if  let photoUrl = result["picture"] {
                                            let imageUrl = String(describing: photoUrl)
                                            self.name = profile?.name
                                            self.email = profile?.email
                                            self.type = "Google.com"
                                            
                                            
                                            
                                            
                                            Alamofire.request(imageUrl).responseImage { response in
                                                
                                                
                                                if let image = response.result.value {
                                                    
                                                    
                                                    
                                                    let metaData = StorageMetadata()
                                                    var downloadedUrl = ""
                                                    let imageUID = UUID().uuidString
                                                    metaData.contentType = "image/jpeg"
                                                    var imgData = Data()
                                                    imgData = UIImageJPEGRepresentation(image, 1.0)!
                                                    
                                                    
                                                    
                                                    
                                                    DataService.instance.AvatarStorageRef.child(imageUID).putData(imgData, metadata: metaData) { (meta, err) in
                                                        
                                                        if err != nil {
                                                            print(err?.localizedDescription as Any)
                                                            return
                                                        }
                                                        let Url = meta?.downloadURL()?.absoluteString
                                                        
                                                        let downUrl = Url! as String
                                                        let downloadUrl = downUrl as NSString
                                                        
                                                        downloadedUrl = downloadUrl as String
                                                        self.avatarUrl = downloadedUrl
                                                        print(self.name!)
                                                        print(self.email!)
                                                        print(self.gender!)
                                                        print(downloadedUrl)
                                                        print(self.type!)
                                                        
                                                        SwiftLoader.hide()
                                                        self.performSegue(withIdentifier: "moveToGoogleSupportVC", sender: nil)
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                    }
                                                    
                                                }
                                                
                                                
                                                
                                                
                                            }
                                            
                                            
                                        }
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                    }
                                case .failure:
                                    
                                    self.showErrorAlert("Oops!", msg: "CRACC: Can't get information from Google")
                                    return
                                    
                                    
                                    // error handling
                                }
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                            }
                            
                            
                        } else {
                            
                            
                            
                            self.performSegue(withIdentifier: "MoveToMapVC", sender: nil)
                            
                            
                        }
                    })
                }
                
        }
    }
        
       
        
        
        /*
        print(user.profile.imageURL(withDimension: 500))
        print(user.profile.email)
        print(user.profile.name)
        */
        
        
    }
    
    
    
    @IBAction func loginWithEmailBtnPressed(_ sender: Any) {
        
        
        if let email = emailTextField.text, email != "", let pwd = pwdTextField.text, pwd != "" {
            
            
            self.performSegue(withIdentifier: "MoveToMapVC", sender: nil)
            
        } else {
            
            self.showErrorAlert("Oops !!!", msg: "CRACC: You need to fill up email and password to get in.")
            
            
        }
        
        
        
        
    }
    
    @IBAction func FaceBookBtnPressed(_ sender: Any) {
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                
                self.showErrorAlert("Oops !!", msg: ("CRACC: Unable to authenticate with Facebook - \(String(describing: error))"))
                return
                
            } else if result?.isCancelled == true {
                self.showErrorAlert("Oops !!", msg: ("CRACC: User cancelled Facebook authentication - \(String(describing: error))"))
                return
            } else {
                print("CRACC: Successfully authenticated with Facebook")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.swiftLoader()
                self.firebaseAuth(credential)
                
            }
        }
        
        
    }
    
    func firebaseAuth(_ credential: AuthCredential) {
        
        Auth.auth().signIn(with: credential, completion: { (user, error) in
            if error != nil {
                self.showErrorAlert("Oops!!!", msg: "CRACC: Unable to authenticate with Firebase - \(String(describing: error))")
                return
            } else {
                if let user = user {
                    self.type = credential.provider
                    userUID = user.uid
                    print(userUID)
                    
                    
                    DataService.instance.checkFacebookUserRef.child(userUID).observeSingleEvent(of: .value, with: { (snapShot) in
                        
                        if snapShot.value is NSNull {
                            
                            
                            self.getData()
                            
                        } else {
                            
                            
                            SwiftLoader.hide()
                            self.performSegue(withIdentifier: "MoveToMapVC", sender: nil)
                            
                            
                        }
                    })
                    
                    
                }
            }
        })
        
    }

    func getData() {
    
        FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, email,age_range,gender, picture.type(large)"]).start(completionHandler: { (connection, result, error) -> Void in
            if (error == nil){
                if let fbDetails = result as? Dictionary<String, Any> {
                    if let names = fbDetails["name"] {
                        self.name = names as? String
                    }
                    
                    if let emails = fbDetails["email"] {
                        self.email = emails as? String
                    }
                    
                    if let ageRange = fbDetails["age_range"] as? Dictionary<String, Any> {
                        
                        if let ages = ageRange["max"] {
                        
                            let age = ages as! Int
                            let date = Date()
                            let calendar = Calendar.current
                            
                            let year = calendar.component(.year, from: date)
                            let currentBirthday = year - age
                            self.birthday = String(currentBirthday)
                        
                        }
                        
                    }
                    if let genders = fbDetails["gender"] {
                        self.gender = genders as? String
                    }

                    
                    if let picture = fbDetails["picture"] as? Dictionary<String, Any> {
                        
                        if let data = picture["data"] as? Dictionary<String, Any> {
                            
                            if let url = data["url"] {
                                let imageUrl = String(describing: url)
                                
                                Alamofire.request(imageUrl).responseImage { response in
                                    
                                    if let image = response.result.value {
                                        
                                        
                                        let metaData = StorageMetadata()
                                        var downloadedUrl = ""
                                        let imageUID = UUID().uuidString
                                        metaData.contentType = "image/jpeg"
                                        var imgData = Data()
                                        imgData = UIImageJPEGRepresentation(image, 1.0)!
                                        
                                        
                                        
                                        
                                        DataService.instance.AvatarStorageRef.child(imageUID).putData(imgData, metadata: metaData) { (meta, err) in
                                            
                                            if err != nil {
                                                print(err?.localizedDescription as Any)
                                                return
                                            }
                                            let Url = meta?.downloadURL()?.absoluteString
                                            
                                            let downUrl = Url! as String
                                            let downloadUrl = downUrl as NSString
                                            
                                            downloadedUrl = downloadUrl as String
                                            print(self.name!)
                                            print(self.birthday!)
                                            print(self.email!)
                                            print(self.gender!)
                                            print(downloadedUrl)
                                            
                                        
                                            
                                            let profile: Dictionary<String, AnyObject> = ["Type": self.type as AnyObject,"Birthday": self.birthday as AnyObject, "Name": self.name as AnyObject, "Email": self.email as AnyObject, "Gender": self.gender! as AnyObject, "avatarUrl": downloadedUrl as AnyObject, "Stars": 0 as AnyObject,"Timestamp": ServerValue.timestamp() as AnyObject]
                                            
                                        DataService.instance.UsersRef.child("Facebook").child(userUID).setValue(profile)
                                        DataService.instance.checkFacebookUserRef.child(userUID).setValue(["Timestamp": ServerValue.timestamp()])
                                        DataService.instance.mainDataBaseRef.child("User").child(userUID).child("Game Created").setValue(["defalut": "defaults"])
                                        DataService.instance.mainDataBaseRef.child("User").child(userUID).child("Game Joined").setValue(["defalut": "defaults"])
                                        DataService.instance.mainDataBaseRef.child("User").child(userUID).child("Chat List").setValue(["defalut": "defaults"])
                                        DataService.instance.mainDataBaseRef.child("User").child(userUID).child("Interested List").setValue(["defalut": "defaults"])
                                        DataService.instance.mainDataBaseRef.child("User").child(userUID).child("Community List").setValue(["defalut": "defaults"])
                                
                                            
                                            
                                        
                                            SwiftLoader.hide()
                                            self.performSegue(withIdentifier: "MoveToMapVC", sender: nil)
                                            
                                        
                                        
                                            
                                            
                                            
                                        }

                                    }
                                }
                                
                                
                               
                                
                            }
                            
                        }
                        
                        
                        
                    
                    }
                    
                    
                    
                    
                    
                
                    
                    
                    
                    
                }
                
                
                //self.getFriendList()
            }else{
                print("Error getting user information \(String(describing: error?.localizedDescription))")

                return
            }
            
        })
    
    
    }
    
    
    
    
    
    
   
    
    
    func getFriendList() {
        let params = ["fields": "id, first_name, last_name, name, email, picture"]
        
        let graphRequest = FBSDKGraphRequest(graphPath: "/me/friends", parameters: params)
        let connection = FBSDKGraphRequestConnection()
        connection.add(graphRequest, completionHandler: { (connection, result, error) in
            if error == nil {
                if let userData = result as? [String:Any] {
                    if userData.count <= 1 {
                        print("nil")
                    } else {
                        
                        print(userData)
                        
                        
                    }
                }
            } else {
                print("Error Getting Friends \(String(describing: error))");
                return
            }
            
        })
        
        connection.start()
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
    
    // show error alert
    
    // func show error alert
    
    func showErrorAlert(_ title: String, msg: String) {
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    func swiftLoader() {
    
        var config : SwiftLoader.Config = SwiftLoader.Config()
        config.size = 170
        
        config.backgroundColor = UIColor.clear
        config.spinnerColor = UIColor.white
        config.titleTextColor = UIColor.white
        
        
        config.spinnerLineWidth = 3.0
        config.foregroundColor = UIColor.black
        config.foregroundAlpha = 0.8
        
        
        SwiftLoader.setConfig(config: config)
        
        
        SwiftLoader.show(title: "", animated: true)
    
    
    
    
    
    
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moveToGoogleSupportVC"{
            if let destination = segue.destination as? GoogleSupportVC{
               destination.name = name
               destination.type = type
               destination.gender = gender
               destination.email = email
               destination.avatarUrl = avatarUrl
            }
        }
    }
    
}
