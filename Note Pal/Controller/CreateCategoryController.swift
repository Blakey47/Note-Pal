//
//  CreateCategoryController.swift
//  Note Pal
//
//  Created by Darragh on 11/21/17.
//  Copyright © 2017 Darragh. All rights reserved.
//

import UIKit

class CreateCategoryController: UIViewController {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.backgroundColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        
        view.backgroundColor = .white
        
        
        
        
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
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(separatorLine)
        separatorLine.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        separatorLine.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        separatorLine.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        separatorLine.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
    }
    
}
