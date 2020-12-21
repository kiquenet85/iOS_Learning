//
//  MapLoginViewController.swift
//  PitchPerfectUiKit
//
//  Created by Nestor Diazgranados on 12/20/20.
//  Copyright © 2020 NesDupier. All rights reserved.
//

import UIKit

class MapLoginViewController: UIViewController {
    
    let MAP_SCREEN_SEGUE = "mapStudents"
    
    @IBOutlet weak var mapUser: UITextField!
    @IBOutlet weak var mapPassword: UITextField!
    @IBOutlet weak var mapBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        mapUser.text = ""
        mapPassword.text = ""
    }
    
    @IBAction func onLoginBtnClicked(_ sender: Any) {
        UdacityClient.login(mapUser.text!, mapPassword.text!){
            (success, error) in
            
            if success {
                self.performSegue(withIdentifier: self.MAP_SCREEN_SEGUE, sender: nil)
            } else {
                self.showAlertError(error: error!)
            }
        }
    }
    
    
    func showAlertError(title: String = "Login error", error: Error){
        let alertcontroller = UIAlertController()
        alertcontroller.title = title
        alertcontroller.message = error.localizedDescription
        print(error)
        
        let okAction = UIAlertAction(title: "ok", style: UIAlertAction.Style.default) { action in
            self.dismiss(animated: true, completion: nil)
        }
        
        alertcontroller.addAction(okAction)
        self.present(alertcontroller, animated: true, completion: nil)
    }
    
}

