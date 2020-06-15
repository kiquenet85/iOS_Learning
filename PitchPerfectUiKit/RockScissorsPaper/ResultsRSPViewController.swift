//
//  GameResultsRSPViewController.swift
//  PitchPerfectUiKit
//
//  Created by Nestor Diazgranados on 6/14/20.
//  Copyright © 2020 NesDupier. All rights reserved.
//

import UIKit

class ResultsRSPViewController: UIViewController {

    @IBOutlet weak var dismissBtn: UIButton!
    var hideModalDismiss = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dismissBtn.isHidden = hideModalDismiss
    }

    @IBAction func dismissOnModal(){
        self.dismiss(animated: true, completion: nil)
    }
}
