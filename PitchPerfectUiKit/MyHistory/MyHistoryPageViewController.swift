//
//  MyHistoryPageViewController.swift
//  PitchPerfectUiKit
//
//  Created by Nestor Diazgranados on 7/6/20.
//  Copyright © 2020 NesDupier. All rights reserved.
//

import Foundation
import UIKit

class MyHistoryPageViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Start Over", style: .plain, target: self, action: #selector(startOver))
    }
    
    @objc func startOver() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
    
    //View controllers can work as a stack using push and pop, every time we make a pop the system deallocate view controller
    deinit {
        print("View controller Deallocated.")
    }
}
