//
//  ViewController.swift
//  FlexNotes
//
//  Created by Anil on 04/04/23.
//  Copyright © 2023 Variance. All rights reserved.
//

import UIKit
import CoreData

//MARK:- Protocol --

protocol HandleLocation {
    func Location(Loc : String, lat : Double, long : Double)
}

class NotesViewController: UIViewController {

    //MARK:- Var Declaration --
    
    var handler = CoreDataHandler()
    var picker = UIImagePickerController()
    var HandleMapSearchDelegate : HandleMapSearch? = nil
    var Lats : Double = 0.0
    var Longs : Double = 0.0
    
    //MARK:- Outlets --
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var btnImage: UIButton!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var btnLocation: UIButton!
    @IBOutlet weak var textFieldTitle: UITextField!
    @IBOutlet weak var textViewSubTitle: UITextView!
    @IBOutlet weak var btnSave: UIBarButtonItem!
    
    //MARK:- View LifeCycle --
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textViewSubTitle.text = "Enter SubTitle Here..."
        textViewSubTitle.textColor = UIColor.lightGray
        textViewSubTitle.layer.borderWidth = 1
        textViewSubTitle.layer.borderColor = UIColor.lightGray.cgColor
        textViewSubTitle.layer.cornerRadius = 5
        textFieldTitle.layer.borderColor = UIColor.lightGray.cgColor
        textFieldTitle.layer.borderWidth = 1
        textFieldTitle.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        
    }

    //MARK:- Action Methods --
    
    @IBAction func AddImage(_ sender: Any) {
        SelectImage()
    }
    
    @IBAction func AddLocation(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MapVC") as! MapViewController
            nextViewController.HandleLocationDelegate = self
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @IBAction func Save(_ sender: Any) {
        
        // Use if condition for Check
        if (imageView.image == nil || textFieldTitle.text?.isEmpty == true || textViewSubTitle.text == "Enter SubTitle Here..." || labelLocation.text == "Select Location" ){
            let alert = UIAlertController(title: "Alert", message: "All Fields are Mandatory for Fill !!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }else{
            // Set Value into DataBase
            let imageString = convertImageToBase64String(img: imageView.image!)
            let context = handler.getContext()
            let entity = NSEntityDescription.entity(forEntityName: "Notes", in: context)
            let manageObject = NSManagedObject(entity: entity!, insertInto: context)
            
                manageObject.setValue(imageString, forKey: "image")
                manageObject.setValue(textFieldTitle.text, forKey: "title")
                manageObject.setValue(textViewSubTitle.text, forKey: "subtitle")
                manageObject.setValue(labelLocation.text, forKey: "location")
                manageObject.setValue(Lats, forKey: "latitude")
                manageObject.setValue(Longs, forKey: "longitude")
            
            do {
                try handler.getContext().save()
            } catch let Error as NSError {
                print("Data Not saved it Shows Error: \(Error)")
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //MARK:- Functions --
    
    func SelectImage(){
        let alert = UIAlertController(title: "Select", message: "", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "camera", style: .default, handler: { (view) in
                // Use Func for Picking Image through Camera
                guard UIImagePickerController.isSourceTypeAvailable(.camera) else{
                    self.showToast("This Device has No Camera...")
                    return
                }
                self.picker.allowsEditing = false
                self.picker.cameraDevice = .rear
                self.picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera)!
                self.picker.delegate = self
                self.present(self.picker, animated: true, completion: nil)
            }))
            
            alert.addAction(UIAlertAction(title: "Library", style: .default, handler: {(view) in
                // Use Func for Picking Image from Album
                guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else{
                    self.showToast("This Device has No library Access...")
                    return
                }
                self.picker.allowsEditing = false
                self.picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
                self.picker.delegate = self
                self.present(self.picker, animated: true, completion: nil)
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
    }

}

//MARK:- Delegate Methods --

extension NotesViewController : HandleLocation,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate{
    
        func Location(Loc: String, lat: Double, long: Double) {
            labelLocation.text = Loc
            labelLocation.textColor = .black
            Lats = lat
            Longs = long
            print("Lat : \(lat)")
            print("Long : \(long)")
        }
    
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage{
                imageView.image = image
            }
            dismiss(animated: true, completion: nil)
        }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textViewSubTitle.textColor == UIColor.lightGray{
            textViewSubTitle.text = nil
            textViewSubTitle.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textViewSubTitle.text.isEmpty{
            textViewSubTitle.text  = "Enter SubTitle Here..."
            textViewSubTitle.textColor = UIColor.lightGray
        }
    }
}
