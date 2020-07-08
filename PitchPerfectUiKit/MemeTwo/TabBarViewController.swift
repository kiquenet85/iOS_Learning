//
//  TabBarViewController.swift
//  PitchPerfectUiKit
//
//  Created by Nestor Diazgranados on 7/7/20.
//  Copyright © 2020 NesDupier. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.  //1. Set up navigation bar.
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        self.navigationItem.rightBarButtonItem = add
    }
    
    @objc func addTapped(){
        performSegue(withIdentifier: "meme1.2", sender: nil)
    }
}
