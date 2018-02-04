//
//  CategoriesController.swift
//  Note Pal
//
//  Created by Darragh on 11/21/17.
//  Copyright © 2017 Darragh. All rights reserved.
//

import UIKit
import CoreData

class CategoriesController: UITableViewController {
    
    var categories = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.categories = CoreDataManager.shared.fetchCategories()
        
        navigationItem.title = "Note Pal"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(handleReset))
        setupPlusButtonInNavBar(selector: #selector(handleAddCategory))
        navigationItem.rightBarButtonItem?.tintColor = .darkPurple
        tableView.separatorColor = .clear
        tableView.tableFooterView = UIView()
    }
    
        
}







