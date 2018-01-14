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
}
