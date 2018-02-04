//
//  CreateTaskController.swift
//  Note Pal
//
//  Created by Darragh on 2/4/18.
//  Copyright © 2018 Darragh. All rights reserved.
//

import UIKit

protocol CreateTaskControllerDelegate {
    func didAddTask(task: Task)
}

class CreateTaskController: UIViewController {
    
    var delegate: CreateTaskControllerDelegate?
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Create Task"
        view.backgroundColor = .white
        setupCancelButton()
        setupUI()
        
        setupSaveButton(selector: #selector(handleSave))
    }
    
    @objc private func handleSave() {
        guard let taskName = nameTextField.text else { return }
        let tuple = CoreDataManager.shared.createTask(taskName: taskName)
        if let error = tuple.1 {
            print(error)
        } else {
            dismiss(animated: true, completion: {
                self.delegate?.didAddTask(task: tuple.0!)
            })
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
    }
}

