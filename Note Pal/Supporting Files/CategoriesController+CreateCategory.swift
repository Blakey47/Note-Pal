//
//  CategoriesController+CreateCategory.swift
//  Note Pal
//
//  Created by Darragh on 1/24/18.
//  Copyright © 2018 Darragh. All rights reserved.
//

import UIKit

extension CategoriesController: CreateCategoryControllerDelegate {
    
    func didEditCategory(category: Category) {
        let row = categories.index(of: category)
        let reloadIndexPath = IndexPath(row: row!, section: 0)
        tableView.reloadRows(at: [reloadIndexPath], with: .middle)
    }
    
    func didAddCategory(category: Category) {
        categories.append(category)
        let newIndexPath = IndexPath(row: categories.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
}
