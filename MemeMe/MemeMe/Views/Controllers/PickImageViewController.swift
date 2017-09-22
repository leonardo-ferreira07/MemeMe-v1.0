//
//  PickImageViewController.swift
//  MemeMe
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 20/09/17.
//  Copyright © 2017 Leonardo Ferreira. All rights reserved.
//

import UIKit

class PickImageViewController: UIViewController {
    
    enum TextsForFields: String {
        case top = "TOP"
        case bottom = "BOTTOM"
    }
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var topBarConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var topBar: UIToolbar!
    @IBOutlet weak var bottomBar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    var hadAnimation: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configDefaulTextAttributes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        resetShareButton()
        
        resignTextFields()
        subscribeToKeyboardNotifications()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !hadAnimation {
            hadAnimation = true
            animateTextFields()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        resignTextFields()
        unsubscribeFromKeyboardNotifications()
    }
    
    // MARK: - Segue navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? ChooseFontViewController {
            viewController.callbackFont = { (font) in
                self.configDefaulTextAttributes(withFont: font)
            }
        }
    }

    // MARK: - Actions
    
    @IBAction func pickImageFromLibraryClicked(_ sender: UIBarButtonItem) {
        chooseSourceType(sourceType: .photoLibrary)
    }
    
    @IBAction func pickImageFromCameraClicked(_ sender: UIBarButtonItem) {
        chooseSourceType(sourceType: .camera)
    }
    
    @IBAction func shareClicked(_ sender: UIBarButtonItem) {
        let memeImage = MemeHelper.generateMemedImage(self)
        self.presentActivityController(withImage: memeImage, completion: {
            MemeHelper.save(topText: self.topTextField.text ?? "",
                            bottomText: self.bottomTextField.text ?? "",
                            originalImage: self.memeImageView.image!,
                            memeImage: memeImage)
            self.clearEditor()
        })
    }
    
    @IBAction func cancelButtonClicked(_ sender: UIBarButtonItem) {
        clearEditor()
    }
    
    func chooseSourceType(sourceType: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true, completion: nil)
    }
    
}

// MARK: - Image Picker Delegate

extension PickImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            memeImageView.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        memeImageView.image = nil
        picker.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Text Attributes

extension PickImageViewController {
    func textFieldTextAttributes(withFont font: String? = nil) -> [String: Any] {
        
        return [
            NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
            NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
            NSAttributedStringKey.font.rawValue: UIFont(name: font ?? "Impact", size: 40)!,
            NSAttributedStringKey.strokeWidth.rawValue: -5.0]
    }
}

// MARK: - Keyboard Notifications

extension PickImageViewController {
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if (UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight) && topBarConstraint.constant == 0  {
            self.topBarConstraint.constant -= self.topBar.frame.height
        }
        self.bottomLayoutConstraint.constant += self.getKeyboardHeight(notification)
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        if self.topBarConstraint.constant == -self.topBar.frame.height {
            self.topBarConstraint.constant = 0
        }
        self.bottomLayoutConstraint.constant -= self.getKeyboardHeight(notification)
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        if let userInfo = notification.userInfo {
            if let keyboardSize = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue {
                return keyboardSize.cgRectValue.height
            }
        }
        return 0.0
    }
}

// MARK: - TextField Delegate

extension PickImageViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == TextsForFields.top.rawValue || textField.text == TextsForFields.bottom.rawValue {
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}

// MARK: - Configs Meme Editor

extension PickImageViewController {
    func clearEditor() {
        memeImageView.image = nil
        resetShareButton()
        configDefaulTextAttributes()
        resignTextFields()
    }
    
    func resetShareButton() {
        shareButton.isEnabled = memeImageView.image == nil ? false : true
    }
    
    func resignTextFields() {
        topTextField.resignFirstResponder()
        bottomTextField.resignFirstResponder()
    }
    
    func configDefaulTextAttributes(withFont font: String? = nil) {
        topTextField.defaultTextAttributes = textFieldTextAttributes(withFont: font)
        topTextField.textAlignment = .center
        topTextField.text = TextsForFields.top.rawValue
        bottomTextField.defaultTextAttributes = textFieldTextAttributes(withFont: font)
        bottomTextField.textAlignment = .center
        bottomTextField.text = TextsForFields.bottom.rawValue
    }
}

// MARK: - TextFields animations

extension PickImageViewController {
    func animateTextFields() {
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.bottomTextField.animateShakeUpDown()
        }
        topTextField.animateShakeUpDown()
        CATransaction.commit()
    }
}
