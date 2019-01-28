//
//  MemeEditorViewController.swift
//  Memo 2.0 Project
//
//  Created by apple on 14/03/1440 AH.
//  Copyright © 1440 Student@Udacity. All rights reserved.
//
//////////////////
import UIKit
import Foundation
//////////////////
class MemeEditorViewController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {


    // ******************************************************* //
    // Image View
    @IBOutlet weak var imageView: UIImageView!
    // Top Tool Bar
    @IBOutlet weak var topToolBar: UIToolbar!
    // Bottom Tool Bar
    @IBOutlet weak var bottomToolBar: UIToolbar!
    // Top Text Field
    @IBOutlet weak var topTextField: UITextField!
    // Bottom Text Field
    @IBOutlet weak var bottomTextField: UITextField!
    // Share Button
    @IBOutlet weak var shareButton: UIBarButtonItem!
    // Camera Button
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    // Text Delegates
    let textFieldDelegates = textFieldsDelegates()
    // Image
    var image = UIImage()
    // ******************************************************* //
    func configureTextfield(textfield: UITextField, attributes: [NSAttributedString.Key: Any]){
        textfield.delegate = textFieldDelegates
        textfield.defaultTextAttributes = attributes
        textfield.textAlignment = .center
    }
    // ******************************************************* //
    func configureBars(_isHidden: Bool){
        self.topToolBar.isHidden = _isHidden
        self.bottomToolBar.isHidden = _isHidden
    }
    // ******************************************************* //
    override func viewDidLoad() {
        super.viewDidLoad()
        // Attributes //
        // ++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
        let memeTextAttributes : [NSAttributedString.Key:Any] =
            [ NSAttributedString.Key(rawValue: NSAttributedString.Key.strokeColor.rawValue): UIColor.black,
              
              NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.white,
              
              NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
                 // Mark: // Should put negative values
                // Source // https://stackoverflow.com/questions/47774748/swift-nsattributedstringkey-not-applying-foreground-color-correctly
              NSAttributedString.Key(rawValue: NSAttributedString.Key.strokeWidth.rawValue): Float.init(-5.0)]
        
        // ++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
        // To Give the Top & Bottom text fields an Attributes
        configureTextfield(textfield: topTextField, attributes: memeTextAttributes)
        configureTextfield(textfield: bottomTextField, attributes: memeTextAttributes)
     
        // ++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
        // To Disable the Camera & Share Buttons go to the function
        disableButtons()
    }
    // ******************************************************* //
   
    func disableButtons() {
        // Disable Share Button
        shareButton.isEnabled = false
        
        // Disable Camera Button
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)
    }
  // ******************************************************* //
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    // ******************************************************* //
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    // ******************************************************* //
    func subscribeToKeyboardNotifications() {
        // show
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        // hide
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    // ******************************************************* //
    func unsubscribeFromKeyboardNotifications() {
        // show
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        // hide
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    // ******************************************************* //
    @objc func keyboardWillShow(_ notification:Notification) {
        
        if (bottomTextField.isFirstResponder) {
           view.frame.origin.y -= getKeyboardHeight(notification)
        }
        
    }
    // ******************************************************* //
    @objc func keyboardWillHide(_ notification:Notification) {
        
        view.frame.origin.y = 0
    }
    // ******************************************************* //
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    // ******************************************************* //
    // Share Button
    @IBAction func shareMemeImage(_ sender: Any) {
        
        let generateMemeImage = generateMemedImage()
        
        let ac = UIActivityViewController(activityItems: [generateMemeImage], applicationActivities: [])
        present(ac, animated: true)
        
        ac.completionWithItemsHandler = {
            (activityType, completed, returnedItems, error) in
            
            if completed {
                self.save(memedImage: generateMemeImage)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }


    // ******************************************************* //
    func generateMemedImage() -> UIImage {
        
        // Hide toolbar and navbar
        configureBars(_isHidden: true)
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // Show toolbar and navbar
        configureBars(_isHidden: false)
        
        return memedImage
        //
        
    }
    // ******************************************************* //
    // Pick image from Camera or Album
    @IBAction func pickAnImage(_ sender: Any) {
        let imagePickerButton = sender as AnyObject
        switch (imagePickerButton.tag) {
            
        case 1 :// For Camera
            chooseImageFromCameraOrPhoto(source: .camera)
            
        case 0 : // For Album
            chooseImageFromCameraOrPhoto(source: .photoLibrary)
            
        default:
            print("Error!!!!")
        }
        
    }
    // ******************************************************* //
    func chooseImageFromCameraOrPhoto(source: UIImagePickerController.SourceType) {
        // Image Picker Controller
        let imagePickerController = UIImagePickerController()
        //
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = source
        present(imagePickerController, animated: true, completion: nil)
    }
     // ******************************************************* //
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if picker.sourceType == .camera {
            
            print("camera")
            dismiss(animated: true, completion: nil)
            imageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        }
        else {
            if let picked = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                imageView.contentMode = .scaleAspectFit
                imageView.image = picked
                shareButton.isEnabled = true
            dismiss(animated: true, completion: nil)
        }
    }
 }
    // ******************************************************* //
    
    func save (memedImage : UIImage) {
     // Create the meme
        let meme = Meme (topText: topTextField.text!, bottomText: bottomTextField.text!, image: imageView.image!, memedImage: memedImage)
        // Add (meme) to the meme array in AppDelegate 
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memes.append(meme)
       
    }
    // ******************************************************* //
    // To stop the process of (Taken a Meme) // 
    @IBAction func cancelButton(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
}
