//
//  CreateTaskController.swift
//  Note Pal
//
//  Created by Darragh on 2/4/18.
//  Copyright © 2018 Darragh. All rights reserved.
//

import UIKit
import DateTimePicker

protocol CreateTaskControllerDelegate {
    func didAddTask(task: Task)
}

class CreateTaskController: UIViewController {
    
    var category: Category?
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
    
    let dueDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Due Date"
        label.backgroundColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dueDateTextField: UITextField = {
        let textView = UITextField()
        textView.text = ""
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
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
        guard let category = category else { return }
        
        let tuple = CoreDataManager.shared.createTask(taskName: taskName, category: category)
        if let error = tuple.1 {
            print(error)
        } else {
            dismiss(animated: true, completion: {
                self.delegate?.didAddTask(task: tuple.0!)
            })
        }
    }
    
    @objc func handleDateSelection() {
        let picker = DateTimePicker.show(selected: Date.init())
        picker.is12HourFormat = true
        picker.completionHandler = { date in
            self.dueDateTextField.inputView = picker
//            self.dueDateTextField.text = picker.selectedDate.
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
        
        view.addSubview(dueDateLabel)
        dueDateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        dueDateLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        dueDateLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        dueDateLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(dueDateTextField)
        dueDateTextField.topAnchor.constraint(equalTo: dueDateLabel.topAnchor).isActive = true
        dueDateTextField.leftAnchor.constraint(equalTo: dueDateLabel.rightAnchor).isActive = true
        dueDateTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        dueDateTextField.bottomAnchor.constraint(equalTo: dueDateLabel.bottomAnchor).isActive = true
    }
}

