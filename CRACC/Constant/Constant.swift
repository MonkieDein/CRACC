//
//  Constant.swift
//  CRACC
//
//  Created by Khoi Nguyen on 9/30/17.
//  Copyright © 2017 Cracc LLC. All rights reserved.
//

import Foundation
import UIKit


let Shadow_Gray: CGFloat = 120.0 / 255.0
var userUID = ""
let GoogleMap_key = "AIzaSyDBHwN1y1awDobJnCwtiQBuYmROSMUfMCg"
let OpenMapWeather_key = "b90582f9d2ca0ab563954574697ea5b9"


var Avatarimage: UIImage?
var name = ""
var birthday = ""
var email = ""



func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
    let size = image.size
    
    let widthRatio  = targetSize.width  / image.size.width
    let heightRatio = targetSize.height / image.size.height
    
    // Figure out what our orientation is, and use that to form the rectangle
    var newSize: CGSize
    if(widthRatio > heightRatio) {
        newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
    } else {
        newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
    }
    
    // This is the rect that we've calculated out and this is what is actually used below
    let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
    
    // Actually do the resizing to the rect using the ImageContext stuff
    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
    image.draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage!
}


