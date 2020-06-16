//
//  MemeEditTextDelegate.swift
//  PitchPerfectUiKit
//
//  Created by Nestor Diazgranados on 6/15/20.
//  Copyright © 2020 NesDupier. All rights reserved.
//

import Foundation
import UIKit

class MemeEditTextDelegate: NSObject, UITextFieldDelegate {
    
    //Clear whether is the first time, so default text is displaying.
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == MemeOneViewController.DefaultText.DEFAULT_TOP_TEXT || textField.text == MemeOneViewController.DefaultText.DEFAULT_BOTTOM_TEXT {
            textField.text = ""
        }
    }
    
    //Hide the keyboard when pressing return.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
