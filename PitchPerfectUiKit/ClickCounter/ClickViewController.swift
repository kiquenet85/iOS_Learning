//
//  ClickViewController.swift
//  PitchPerfectUiKit
//
//  Created by Nestor Diazgranados on 5/31/20.
//  Copyright © 2020 NesDupier. All rights reserved.
//

import UIKit

class ClickViewController: UIViewController {
    
    var ccLabel : UILabel!
    var ccSecondLabel : UILabel!
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildProgramatically()
    }
    
    func buildProgramatically(){
        ccLabel = UILabel()
        ccLabel.frame = CGRect(x: 150, y: 150, width: 60, height: 60)
        ccLabel.text = "0"
        
        view.addSubview(ccLabel)
        
        ccSecondLabel = UILabel()
        ccSecondLabel.frame = CGRect(x: 300, y: 150, width: 60, height: 60)
        ccSecondLabel.text = "0"
        
        view.addSubview(ccSecondLabel)
        
        let ccButton = UIButton()
        ccButton.frame = CGRect(x: 150, y: 250, width: 60, height: 60)
        ccButton.setTitle("Click", for: .normal)
        ccButton.setTitleColor(UIColor.blue, for: .normal)
        
        view.addSubview(ccButton)
        
        ccButton.addTarget(self, action: #selector(ClickViewController.incrementCount), for: UIControl.Event.touchUpInside)
        
        let ccDecrementBtn = UIButton()
        ccDecrementBtn.frame = CGRect(x: 150, y: 300, width: 120, height: 60)
        ccDecrementBtn.setTitle("Decrement", for: .normal)
        ccDecrementBtn.setTitleColor(UIColor.red, for: .normal)
        
        view.addSubview(ccDecrementBtn)
        
        ccDecrementBtn.addTarget(self, action: #selector(decrementCount), for: UIControl.Event.touchUpInside)
    }
    
    @objc func incrementCount(){
        self.count += 1
        self.ccLabel.text = "\(count)"
        self.ccSecondLabel.text = "\(count)"
        
        self.ccLabel.backgroundColor = UIColor.clear
        self.ccSecondLabel.backgroundColor = UIColor.clear
    }
    
    @objc func decrementCount(){
        self.count -= 1
        self.ccLabel.text = "\(count)"
        self.ccSecondLabel.text = "\(count)"
        
        self.ccLabel.backgroundColor = UIColor.yellow
        self.ccSecondLabel.backgroundColor = UIColor.yellow
    }
}
