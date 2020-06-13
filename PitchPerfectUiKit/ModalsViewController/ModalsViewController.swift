//
//  ViewController.swift
//  PitchPerfectUiKit
//
//  Created by Nestor Diazgranados on 6/13/20.
//  Copyright © 2020 NesDupier. All rights reserved.
//

import UIKit

class ModalsViewController: UIViewController {
    
    //MARK: Editor Variables
    @IBOutlet var photoPickerBtn : UIButton!
    @IBOutlet var activityViewController : UIButton!
    @IBOutlet var alert : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func openPhotoPicker(){
        let imagePicker = UIImagePickerController()
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func openActivityViewcontroller(){
        let  image = UIImage()
        let controller = UIActivityViewController(activityItems: [image],
                                                  applicationActivities: nil)
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func openAlert(){
        let alertcontroller = UIAlertController()
        alertcontroller.title = "Some title for Alert"
        alertcontroller.message = "Some message for Alert"
        
        let okAction = UIAlertAction(title: "ok", style: UIAlertAction.Style.default) { action in
            self.dismiss(animated: true, completion: nil)
        }
        
        alertcontroller.addAction(okAction)
        present(alertcontroller, animated: true, completion: nil)
    }
}
