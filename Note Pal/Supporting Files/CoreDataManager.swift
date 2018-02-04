//
//  CoreDataManager.swift
//  Note Pal
//
//  Created by Darragh on 1/14/18.
//  Copyright © 2018 Darragh. All rights reserved.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NotePalModels")
        container.loadPersistentStores { (storeDescription, err) in
            if let err = err {
                fatalError("Loading of store failed: \(err)")
            }
        }
        return container
    }()
    
    func fetchCategories() -> [Category] {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Category>(entityName: "Category")
        
        do {
            let categories = try context.fetch(fetchRequest)
            return categories
        } catch let fetchErr {
            print("Failed to fetch categories:", fetchErr)
            return []
        }
    }
    
    func createTask(taskName: String) -> (Task?, Error?) {
        let context = persistentContainer.viewContext
        let task = NSEntityDescription.insertNewObject(forEntityName: "Task", into: context) as! Task
        task.setValue(taskName, forKey: "name")
        do {
            try context.save()
            return (task, nil)
        } catch let err {
            return (nil, err)
        }
    }
    
}
