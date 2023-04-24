//
//  CoreTableVCViewController.swift
//  FlexNotes
//
//  Created by Anil on 04/04/23.
//  Copyright © 2023 Variance. All rights reserved.
//

import UIKit
import CoreData

class CoreTableViewController: UIViewController {
    
    //MARK:- Var Declaration --
    
    var listNotes : [Notes]? = nil
    var managedObjectContext: NSManagedObjectContext?
    var handler = CoreDataHandler()
    var helper = [NotesModel]()
    
    //MARK:- Outlets --
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var EmptyView: UIView!
    @IBOutlet weak var btnAdd: UIButton!
    
    @IBOutlet weak var btnEdit: UIBarButtonItem!
    //MARK:- View LifeCycle --
    
    override func viewDidLoad() {
        super.viewDidLoad()
        managedObjectContext = AppInstance.persistentContainer.viewContext
        btnAdd.layer.cornerRadius = btnAdd.frame.size.width / 2
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.listNotes = CoreDataHandler().getData()
            listNotes?.reverse()
            helper.removeAll()
        if listNotes != nil{
            for obj in listNotes!{
                let noteObj = NotesModel()
                let strTemp = obj.image ?? ""
                if strTemp != ""{
                    let img = convertBase64StringToImage(imageBase64String: strTemp)
                    noteObj.photo = img
                }
                    noteObj.title = obj.title ?? ""
                    noteObj.subtitle = obj.subtitle ?? ""
                helper.append(noteObj)
            }
        }
        tableView.reloadData()
    }
    
    //MARK:- Action Methods --
    
    @IBAction func btnAdd(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextviewController = storyBoard.instantiateViewController(withIdentifier: "NotesVC") as! NotesViewController
        self.navigationController?.pushViewController(nextviewController, animated: true)
    }
    
    @IBAction func EditButtonClick(_ sender: Any) {
        
        tableView.isEditing = !tableView.isEditing
        if tableView.isEditing {
            btnEdit.title = "Done"
        }else{
            btnEdit.title = "Edit"
        }
    }
}

    //MARK:- Delegate Methods --

extension CoreTableViewController : UITableViewDelegate, UITableViewDataSource{
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            let numberOfSections: Int = (self.helper.count)
            if numberOfSections > 0{
                tableView.backgroundView = .none
            }else{
                tableView.backgroundView = EmptyView
                tableView.separatorStyle = .none
            }
            return self.helper.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ListCellTableViewCell
            
            if helper.count > 0{
                let obj = helper[indexPath.row]
                    cell.imgView.image = obj.photo
                    cell.lblTitle.text = obj.title
                    cell.lblSubTitle.text = obj.subtitle
            }
            return cell
        }
    
        func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
            return true
        }
    
        func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
            
            let SelectedItem = listNotes![sourceIndexPath.row]
            listNotes!.remove(at: sourceIndexPath.row)
            listNotes!.insert(SelectedItem, at: destinationIndexPath.row)
            
        }
    
        func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
            return .delete
        }
        
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            
            let manageObjectContext = AppInstance.persistentContainer.viewContext
            let Data = listNotes![indexPath.row]
            
            // Delete Method
            if editingStyle == .delete{
                tableView.beginUpdates()
                manageObjectContext.delete(Data)
                self.listNotes!.remove(at: indexPath.row)
                self.helper.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                do {
                            try manageObjectContext.save()
                        } catch let error as NSError {
                            print("Error with Deleting Data : \(error.userInfo)")
                        }
                }else{
                    print("Delete Row failed")
                }
                
                tableView.endUpdates()
            
        }
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

            let storyBoard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let testVC = storyBoard.instantiateViewController(withIdentifier: "ResultVC") as! ResultViewController
            
            // Pass Data For ListView
            let obj = helper[indexPath.row]
                testVC.Image1 = obj.photo
                testVC.Title1 = obj.title
                testVC.Subtitle1 = obj.subtitle
                testVC.Location1 = self.listNotes![indexPath.row].location ?? ""
                testVC.Lati = self.listNotes![indexPath.row].latitude
                testVC.Longi = self.listNotes![indexPath.row].longitude
                        
            self.navigationController?.pushViewController(testVC, animated: true)
        }
    
}
