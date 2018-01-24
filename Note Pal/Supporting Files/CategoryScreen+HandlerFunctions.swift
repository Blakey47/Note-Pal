//
//  CategoryScreen+HandlerFunctions.swift
//  Note Pal
//
//  Created by Darragh on 1/24/18.
//  Copyright © 2018 Darragh. All rights reserved.
//

import UIKit
import CoreData

extension CategoriesScreen {
    
    @objc private func handleReset() {
        print("Attempting to delete all CoreData Objects...")
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: Category.fetchRequest())
        do {
            try context.execute(batchDeleteRequest)
            var indexPathsToRemove = [IndexPath]()
            for (index, _) in categories.enumerated() {
                let indexPath = IndexPath(row: index, section: 0)
                indexPathsToRemove.append(indexPath)
            }
            categories.removeAll()
            tableView.deleteRows(at: indexPathsToRemove, with: .left)
        } catch let delErr {
            print("Failed to delete objects from CoreData:", delErr)
        }
    }
    
    @objc func handleAddCategory() {
        let createCategoryController = CreateCategoryController()
        let navController = CustomerNavigationController(rootViewController: createCategoryController)
        createCategoryController.delegate = self
        present(navController, animated: true, completion: nil)
        
    }
    
}
