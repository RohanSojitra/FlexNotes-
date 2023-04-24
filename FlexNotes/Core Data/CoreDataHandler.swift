//
//  DataHandler.swift
//  FlexNotes
//
//  Created by Anil on 05/04/23.
//  Copyright © 2023 Variance. All rights reserved.
//

import UIKit
import CoreData

class CoreDataHandler{
    
    func getContext() -> NSManagedObjectContext {
        AppInstance.persistentContainer.viewContext
        
    }
    
    /*func createData(Global : NotesHelper){
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Notes", in: context)
        let manageObject = NSManagedObject(entity: entity!, insertInto: context)
        
        manageObject.setValue(Global.photo, forKey: "image")
        manageObject.setValue(Global.title, forKey: "title")
        manageObject.setValue(Global.subtitle, forKey: "subtitle")
        manageObject.setValue(Global.location, forKey: "location")
        manageObject.setValue(Global.location.latitude, forKey: "latitude")
        manageObject.setValue(Global.location.longitude, forKey: "longitude")
        
        do {
            try context.save()
        } catch let Error as NSError {
            print("Error While get Data: \(Error)")
        }
    }*/
    
    func getData() -> [Notes] {
        let context = getContext()
        var notes : [Notes]? = nil
        do {
            notes = try context.fetch(Notes.fetchRequest())
        } catch {
            print(error)
        }
        return notes!
    }
    
}
