//
//  CategoriesScreen.swift
//  Note Pal
//
//  Created by Darragh on 11/21/17.
//  Copyright © 2017 Darragh. All rights reserved.
//

import UIKit

class CategoriesScreen: UITableViewController, CreateCategoryControllerDelegate {
    
    func didAddCategory(category: Category) {
        categories.append(category)
        let newIndexPath = IndexPath(row: categories.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
    
    var categories = [
        Category(name: "Work"),
        Category(name: "Personal"),
        Category(name: "Home")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Note Pal"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"), style: .plain, target: self, action: #selector(handleAddCategory))
        navigationItem.rightBarButtonItem?.tintColor = .darkPurple
        tableView.separatorColor = .clear
        tableView.tableFooterView = UIView()
    }
    
    @objc func handleAddCategory() {
        let createCategoryController = CreateCategoryController()
        let navController = CustomerNavigationController(rootViewController: createCategoryController)
        createCategoryController.delegate = self
        present(navController, animated: true, completion: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .lightGrey
        return view
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let category = categories[indexPath.row]
        
        cell.textLabel?.text = category.name
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return cell
    }
    
}
