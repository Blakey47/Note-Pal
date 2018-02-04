//
//  CreateTaskController.swift
//  Note Pal
//
//  Created by Darragh on 2/4/18.
//  Copyright © 2018 Darragh. All rights reserved.
//

import UIKit

class CreateTaskController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Create Task"
        setupCancelButton()
        view.backgroundColor = .darkPurple
    }
}

