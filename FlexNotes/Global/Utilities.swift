//
//  Utilities.swift
//  FlexNotes
//
//  Created by Anil on 05/04/23.
//  Copyright © 2023 Variance. All rights reserved.
//

import UIKit

class NotesModel{
    
    var photo = UIImage()
    var title : String = ""
    var subtitle : String = ""
    var location : String = ""
    var latitude : Double = 0.0
    var longitude : Double = 0.0
    
}

func convertImageToBase64String (img: UIImage) -> String {
    let imageData:NSData = img.jpegData(compressionQuality: 0.50)! as NSData //UIImagePNGRepresentation(img)
    let imgString = imageData.base64EncodedString(options: .init(rawValue: 0))
    return imgString
}

func convertBase64StringToImage (imageBase64String:String) -> UIImage {
    let imageData = Data.init(base64Encoded: imageBase64String, options: .init(rawValue: 0))
    let image = UIImage(data: imageData!)!
    return image
}
