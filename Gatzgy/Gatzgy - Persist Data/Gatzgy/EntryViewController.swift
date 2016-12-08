//
//  EntryViewController.swift
//  Gatzgy
//
//  Created by Diego Covarrubias on 12/1/16.
//  Copyright © 2016 Diego Covarrubias. All rights reserved.
//
/*
 Basic layout for this file and core pieces of code courtesy of: https://developer.apple.com/library/content/referencelibrary/GettingStarted/DevelopiOSAppsSwift/index.html#//apple_ref/doc/uid/TP40015214-CH2-SW1
*/

import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: Properties
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    /*
        This value is either passed by `JournalViewController` in `prepareForSegue(_:sender:)`
        or constructed as part of adding a new entry.
    */
    var entry: Entry?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*Establish that Key board is dismissed if the screen is tapped
         courtesty of http://stackoverflow.com/questions/24126678/close-ios-keyboard-by-touching-anywhere-using-swift
        */
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(EntryViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
                
        // Add border to TextView
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.borderColor = UIColor.black.cgColor
        
        // Handle the text field’s user input through delegate callbacks.
        titleTextField.delegate = self
        descriptionTextView.delegate = self
        
        // Set up views if editing an existing Entry.
        if let entry = entry {
            navigationItem.title = entry.title
            titleTextField.text = entry.title
            photoImageView.image = entry.photo
            descriptionTextView.text = entry.descript
        }
        
        // Enable the Save button only if the text field has a valid Entry title.
        checkValidEntryTitle()
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkValidEntryTitle()
        navigationItem.title = textField.text
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        doneButton.isEnabled = false
    }
    
    func checkValidEntryTitle() {
        // Disable the Save button if the text field is empty.
        let text = titleTextField.text ?? ""
        doneButton.isEnabled = !text.isEmpty
    }
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Navigation
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddEntryMode = presentingViewController is SWRevealViewController
        
        if isPresentingInAddEntryMode {
            self.dismiss(animated: true, completion: nil)
        } else {
            navigationController!.popViewController(animated: true)
        }
    }

    @IBAction func done(_ sender: UIBarButtonItem) {
        if doneButton === sender {
            let title = titleTextField.text ?? ""
            let photo = photoImageView.image
            let descript = descriptionTextView.text ?? ""
            
            // Set the entry to be passed to EntryListJournalViewController after the unwind segue.
            entry = Entry(title: title, photo: photo, descript: descript)
        }
        self.performSegue(withIdentifier: "unwindToEntryList", sender: self)
    }
    
    // MARK: Actions
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        // Hide the keyboard.
        titleTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true, completion: nil)
    }

}

