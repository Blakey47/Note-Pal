//
//  TaskController.swift
//  Note Pal
//
//  Created by Darragh on 2/3/18.
//  Copyright © 2018 Darragh. All rights reserved.
//

import UIKit

class TaskController: UITableViewController {
    
    var category: Category?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = category?.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .darkPurple
        setupPlusButtonInNavBar(selector: #selector(handleAdd))
    }
    
    @objc private func handleAdd() {
        let createTaskController = CreateTaskController()
        let navController = CustomNavigationController(rootViewController: createTaskController)
        present(navController, animated: true, completion: nil)
    }
    
}
