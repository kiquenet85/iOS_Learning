//
//  LoginMapViewController.swift
//  PitchPerfectUiKit
//
//  Created by Nestor Diazgranados on 12/20/20.
//  Copyright © 2020 NesDupier. All rights reserved.
//

import UIKit

class LoginMapViewController: UIViewController {
    
    let MAP_SCREEN_SEGUE = "mapStudents"
    
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var userPasswordField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onLoginClick(_ sender: Any) {
        performSegue(withIdentifier: MAP_SCREEN_SEGUE, sender: nil)
    }
    
}
