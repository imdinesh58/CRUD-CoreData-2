//
//  testViewController.swift
//  CoreDataSampleApp
//
//  Created by Apple-1 on 11/17/17.
//  Copyright © 2017 Apple-1. All rights reserved.
//

import UIKit

class testViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let changeName:String = "dinesh"
        changeName.Changemethod()
        print("s ", changeName)
        print(changeName)
    }
    
}

extension String {
    func Changemethod() {
        print("Nirmal")
    }
}
