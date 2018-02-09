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
    func didAddTaskInformation(taskInformation: TaskInformation)
}

class CreateTaskController: UIViewController {
    
    var category: Category?
    var delegate: CreateTaskControllerDelegate?
    var dueDateAnswer = Date()
    let dateFormatter = DateFormatter()
    
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
    
    let dueDateAnswerLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .darkPurple
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let changeDueDateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Change Due Date", for: .normal)
        button.addTarget(self, action: #selector(changeDueDateButtonAction), for: .touchUpInside)
        button.backgroundColor = .darkPurple
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let notesLabel: UILabel = {
        let label = UILabel()
        label.text = "Task Notes"
        label.backgroundColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let notesTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Task Notes Here...."
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.borderStyle = UITextBorderStyle.roundedRect
        textField.keyboardType = .default
        textField.returnKeyType = .done
        textField.clearButtonMode = .whileEditing
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Create Task"
        view.backgroundColor = .white
        setupCancelButton()
        setupUI()
        
        
    }
    
    @objc private func handleSave() {
        guard let taskName = nameTextField.text else { return }
        guard let category = category else { return }
        guard let taskNotes = notesTextField.text else { return }
        let dueDate = dueDateAnswer
        
        let tuple = CoreDataManager.shared.createTask(taskName: taskName, category: category, dueDate: dueDate, taskNotes: taskNotes)
        if let error = tuple.2 {
            print(error)
        } else {
            dismiss(animated: true, completion: {
                self.delegate?.didAddTask(task: tuple.0!)
                self.delegate?.didAddTaskInformation(taskInformation: tuple.1!)
            })
        }
    }
    
    @objc func changeDueDateButtonAction(sender: UIButton) {
        dueDateAnswerLabel.text = ""
        settingUpDueDatePicker()
    }
    
    @objc private func handleDueDate() {
        settingUpDueDatePicker()
    }
    
    func settingUpDueDatePicker() {
        if dueDateAnswerLabel.text == "" {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Select Due Date", style: .plain, target: self, action: #selector(handleDueDate))
            changeDueDateButton.isHidden = true
            let picker = DateTimePicker.show(selected: Date.init())
            picker.is12HourFormat = true
            picker.completionHandler = { date in
                self.dueDateAnswer = picker.selectedDate
                self.dueDateAnswerLabel.text = self.dateFormatter.string(from: self.dueDateAnswer)
                self.settingUpDueDatePicker()
            }
        } else {
            setupSaveButton(selector: #selector(handleSave))
            changeDueDateButton.isHidden = false
        }
        
    }
    
    private func setupUI() {
        setupBackgroundView()
        settingUpDueDatePicker()
        dateFormatter.dateFormat = "HH:mm EEEE, dd MMM"
        
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
        
        view.addSubview(dueDateAnswerLabel)
        dueDateAnswerLabel.topAnchor.constraint(equalTo: dueDateLabel.topAnchor).isActive = true
        dueDateAnswerLabel.leftAnchor.constraint(equalTo: dueDateLabel.rightAnchor).isActive = true
        dueDateAnswerLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        dueDateAnswerLabel.bottomAnchor.constraint(equalTo: dueDateLabel.bottomAnchor).isActive = true
        
        view.addSubview(changeDueDateButton)
        changeDueDateButton.topAnchor.constraint(equalTo: dueDateLabel.bottomAnchor).isActive = true
        changeDueDateButton.leftAnchor.constraint(equalTo: nameTextField.leftAnchor).isActive = true
        changeDueDateButton.rightAnchor.constraint(equalTo: nameTextField.rightAnchor, constant: -16).isActive = true
        changeDueDateButton.heightAnchor.constraint(equalToConstant: 50)
        
        view.addSubview(notesLabel)
        notesLabel.topAnchor.constraint(equalTo: changeDueDateButton.bottomAnchor).isActive = true
        notesLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        notesLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        notesLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(notesTextField)
        notesTextField.topAnchor.constraint(equalTo: notesLabel.topAnchor, constant: 11).isActive = true
        notesTextField.leftAnchor.constraint(equalTo: changeDueDateButton.leftAnchor).isActive = true
        notesTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        notesTextField.heightAnchor.constraint(equalToConstant: 200)
    }
}

