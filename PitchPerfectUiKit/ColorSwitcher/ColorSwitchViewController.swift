//
//  ColorSwitchViewController.swift
//  PitchPerfectUiKit
//
//  Created by Nestor Diazgranados on 6/12/20.
//  Copyright © 2020 NesDupier. All rights reserved.
//

import UIKit

class ColorSwitchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var colorView: UIView!
  
    @IBAction func changeColor(){
        let red = CGFloat(redSlider.value)
        let green = CGFloat(greenSlider.value)
        let blue = CGFloat(blueSlider.value)
        
        colorView.backgroundColor = UIColor(displayP3Red: red, green: green, blue: blue, alpha: 1)
    }
}
