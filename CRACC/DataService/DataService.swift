//
//  DataService.swift
//  CRACC
//
//  Created by Khoi Nguyen on 10/19/17.
//  Copyright © 2017 Cracc LLC. All rights reserved.
//

let FIR_CHILD_USERS = "User Info"
let CRACC = "CRACC"

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseStorage




class DataService {
    
    
    
    fileprivate static let _instance = DataService()
    
    static var instance: DataService {
        return _instance
    }
    
    
    var mainDataBaseRef: DatabaseReference {
        return Database.database().reference().child(CRACC)
    }
    
    var checkFacebookUserRef: DatabaseReference {
        return mainDataBaseRef.child("Facebook")
    }
    var checkGoogleUserRef: DatabaseReference {
        return mainDataBaseRef.child("Google")
    }
    var checkEmailUserRef: DatabaseReference {
        return mainDataBaseRef.child("Email")
    }
    
    var UsersRef: DatabaseReference {
        return mainDataBaseRef.child(FIR_CHILD_USERS)
    }
    
    var activeUserNameRef: DatabaseReference {
        return mainDataBaseRef.child("active_usernames")
    }
    
    var mainStorageRef: StorageReference {
        return Storage.storage().reference(forURL: "gs://cracc-c6f5f.appspot.com/")
    }
    
    var VideoStorageRef: StorageReference {
        return mainStorageRef.child("Video Introduction")
    }
    
    var AvatarStorageRef: StorageReference {
        return mainStorageRef.child("Avatar")
    }
    
    
    
    func saveUser(_ uid: String) {
    mainDataBaseRef.child(FIR_CHILD_USERS).child(uid).child("User")
        
    }
    
    let connectedRef = Database.database().reference(withPath: ".info/connected")
    
    
    
    
    
    
}

