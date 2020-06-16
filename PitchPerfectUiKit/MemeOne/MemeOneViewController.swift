//
//  MemeOneViewController.swift
//  PitchPerfectUiKit
//
//  Created by Nestor Diazgranados on 6/15/20.
//  Copyright © 2020 NesDupier. All rights reserved.
//

import UIKit

class MemeOneViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imgMeme: UIImageView!
    @IBOutlet weak var cameraBtn: UIBarButtonItem!
    
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    
    @IBOutlet weak var toolbar: UIToolbar!
    
    
    //MARK: Edit text variables
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.white,
        NSAttributedString.Key.foregroundColor: UIColor.black,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth:  6.0
    ]
    
    let memeEditTextDelegate = MemeEditTextDelegate()
    
    struct DefaultText{
        static let DEFAULT_TOP_TEXT = "TOP"
        static let DEFAULT_BOTTOM_TEXT = "BOTTOM"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1. Set up navigation bar.
        navigationItem.largeTitleDisplayMode = .never
        
        let shareBtn = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        navigationItem.rightBarButtonItems = [shareBtn]
        shareBtn.isEnabled = false
        
        //2. Set up text fields.
        topText.defaultTextAttributes = memeTextAttributes
        topText.textAlignment = .center
        topText.text = DefaultText.DEFAULT_TOP_TEXT
        
        bottomText.defaultTextAttributes = memeTextAttributes
        bottomText.textAlignment = .center
        bottomText.text = DefaultText.DEFAULT_BOTTOM_TEXT
        
        topText.delegate = memeEditTextDelegate
        bottomText.delegate = memeEditTextDelegate
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        cameraBtn.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        
        // set the image with selected resource
        imgMeme.image = image
        navigationItem.rightBarButtonItems?[0].isEnabled = true
    }
    
    //Delegate method to close picker.
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
    
    //MARK: Share Meme image.
    @objc func shareTapped(){
        let activityVC = UIActivityViewController(activityItems: [generateMemedImage()], applicationActivities: [])
        activityVC.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItems?[0]
        
        present(activityVC, animated: true)
    }
    
    //MARK: Generate image
    func generateMemedImage() -> UIImage {
        
        isHiddenNavBarAdtoolbar(hide: true)
        
        var meme = Meme(topText: topText.text!, bottomText: bottomText.text!, originalImage: imgMeme.image, memedImage: nil)
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        isHiddenNavBarAdtoolbar(hide: false)
        
        meme.memedImage = memedImage
        return memedImage
    }
    
    func isHiddenNavBarAdtoolbar(hide : Bool){
        toolbar.isHidden = hide
        self.navigationController?.setNavigationBarHidden(hide, animated: false)
    }
    
    //MARK: Observing keyboard methods
    @objc func keyboardWillShow(_ notification:Notification){
        view.frame.origin.y = -getKeyboardHeight(notification)
    }
    
    @objc func keyboardWillHide(_ notification:Notification){
        view.frame.origin.y = 0
    }
    
    func subscribeToKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
}
