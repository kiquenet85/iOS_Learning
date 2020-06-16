//
//  MemeOneViewController.swift
//  PitchPerfectUiKit
//
//  Created by Nestor Diazgranados on 6/15/20.
//  Copyright © 2020 NesDupier. All rights reserved.
//

import UIKit

class MemeOneViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imgMeme: UIImageView!
    @IBOutlet weak var cameraBtn: UIBarButtonItem!
    
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    
    //MARK: Edit text variables
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth:  32.0
    ]
    let memeEditTextDelegate = MemeEditTextDelegate()
    
    struct DefaultText{
        static let DEFAULT_TOP_TEXT = "TOP MESSAGE"
        static let DEFAULT_BOTTOM_TEXT = "BOTTOM MESSAGE"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topText.textAlignment = .center
        topText.defaultTextAttributes = memeTextAttributes
        
        bottomText.textAlignment = .center
        bottomText.defaultTextAttributes = memeTextAttributes
        
        topText.delegate = memeEditTextDelegate
        bottomText.delegate = memeEditTextDelegate
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraBtn.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        
        // set the image with selected resource
        imgMeme.image = image
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pickAlbumPicture(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromCamera(){
        if cameraBtn.isEnabled {
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .camera
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        }
    }
}
