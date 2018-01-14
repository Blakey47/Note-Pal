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
}

class CreateCategoryController: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        navigationItem.title = "Create Category"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
        
        view.backgroundColor = .white
        
    }
    
    @objc private func handleSave() {
        
        // Initializing Persistance
        let persistentContainer = NSPersistentContainer(name: "NotePalModels")
        persistentContainer.loadPersistentStores { (storeDescription, err) in
            if let err = err {
                fatalError("Loading of store failed: \(err)")
            }
        }
        let context = persistentContainer.viewContext
        let category = NSEntityDescription.insertNewObject(forEntityName: "Category", into: context)
        category.setValue(nameTextField.text, forKey: "name")
        
        // Performing Save
        do {
            try context.save()
        } catch let saveErr {
            print("Failed to save category:", saveErr)
        }
        
        
//        dismiss(animated: true) {
//            guard let name = self.nameTextField.text else { return }
//            let category = Category(name: name)
//            self.delegate?.didAddCategory(category: category)
//        }
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setupUI() {
        let backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(backgroundView)
        backgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
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
