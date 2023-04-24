//
//  ViewViewController.swift
//  FlexNotes
//
//  Created by Anil on 11/04/23.
//  Copyright © 2023 Variance. All rights reserved.
//

import UIKit
import CoreData

class ViewViewController: UIViewController {

    //MARK:- Var Declaration --
    var listNotes : [Notes]? = nil
    var managedObjectContext: NSManagedObjectContext?
    var handler = CoreDataHandler()
    var helper : NotesHelper? = nil
    
    //MARK:- Outlets --
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var lblTitle1: UILabel!
    @IBOutlet weak var textViewSubTitle1: UITextView!
    
    //MARK:- View LifeCycle --
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblTitle1.text = self.listNotes![indexPath.row].title
        
    }
    
}
