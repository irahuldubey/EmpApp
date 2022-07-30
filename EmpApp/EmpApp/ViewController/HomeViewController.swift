//
//  HomeViewController.swift
//  EmpApp
//
//  Created by Rahul Dubey on 7/29/22.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        HomeViewModel().fetchEmployeeList()
        
    }


}

