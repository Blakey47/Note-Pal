//
//  CreateCategoryController.swift
//  Note Pal
//
//  Created by Darragh on 11/21/17.
//  Copyright © 2017 Darragh. All rights reserved.
//

import UIKit
import CoreData

// Custom Delegation
protocol CreateCategoryControllerDelegate {
    func didAddCategory(category: Category)
    func didEditCategory(category: Category)
}

class CreateCategoryController: UIViewController {
    
    var category: Category? {
        didSet {
            nameTextField.text = category?.name
        }
    }
    
    var delegate: CreateCategoryControllerDelegate?
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.backgroundColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGrey
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = category == nil ? "Create Category" : "Edit Category"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        setupCancelButton()
        setupSaveButton(selector: #selector(handleSave))
        
        view.backgroundColor = .white
        
    }
    
    @objc private func handleSave() {
        if category == nil {
            createCatgory()
        } else {
            saveCategoryChanges()
        }
    }
    
    private func saveCategoryChanges() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        category?.name = nameTextField.text
        do {
            try context.save()
            dismiss(animated: true, completion: {
                self.delegate?.didEditCategory(category: self.category!)
            })
        } catch let saveErr {
            print("Failed to save category changes:", saveErr)
        }
    }
    
    private func createCatgory() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let category = NSEntityDescription.insertNewObject(forEntityName: "Category", into: context)
        category.setValue(nameTextField.text, forKey: "name")
        do {
            try context.save()            
            dismiss(animated: true, completion: {
                self.delegate?.didAddCategory(category: category as! Category)
            })
        } catch let saveErr {
            print("Failed to save category:", saveErr)
        }
    }
    
    private func setupUI() {
        setupBackgroundView()
        
        view.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(nameTextField)
        nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
        nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        nameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        
        view.addSubview(separatorLine)
        separatorLine.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        separatorLine.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        separatorLine.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        separatorLine.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
    }
    
}
