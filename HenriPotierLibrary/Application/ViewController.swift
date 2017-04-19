//
//  ViewController.swift
//  HenriPotierLibrary
//
//  Created by Ahmed K on 19/04/2017.
//  Copyright © 2017 Ahmed K. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ApiManager.getAllBooks()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

