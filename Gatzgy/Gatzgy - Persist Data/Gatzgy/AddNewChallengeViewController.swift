//
//  AddNewChallengeViewController.swift
//  Gatzgy
//
//  Created by Diego Covarrubias on 12/6/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//
/*
 Basic layout for this file and core pieces of code courtesy of: https://developer.apple.com/library/content/referencelibrary/GettingStarted/DevelopiOSAppsSwift/index.html#//apple_ref/doc/uid/TP40015214-CH2-SW1
 */

import UIKit

class AddNewChallengeViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: Properties
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var challenge: Challenge?
    var challenges = [Challenge]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
         Navigation Bar code from this source: https://www.appcoda.com/sidebar-menu-swift/
        */
        // Initial set up for navigation bar.
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        // Add border to TextView
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.borderColor = UIColor.black.cgColor
        
        // Handle the text field’s user input through delegate callbacks.
        titleTextField.delegate = self
        descriptionTextView.delegate = self
        
        // Enable the Save button only if the text field has a valid Entry title.
        checkValidEntryTitle()
        
        // Load any saved challenges, otherwise load sample data.
        if let savedChallenges = loadChallenges() {
            challenges += savedChallenges
            
        } else {
            // Load the sample data.
            loadSampleChallenges()
        }
    }
    
    func loadSampleChallenges() {
        challenges += sampleChallenges.defaultChallenges
        saveChallenges()
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
        saveButton.isEnabled = false
    }
    
    func checkValidEntryTitle() {
        // Disable the Save button if the text field is empty.
        let text = titleTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    // MARK: UITextViewDelegate
    func textViewShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        descriptionTextView.resignFirstResponder()
        return true
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
    @IBAction func done(_ sender: UIBarButtonItem) {
        /*
         Main basis for the alert code: http://stackoverflow.com/questions/25511945/swift-alert-view-ios8-with-ok-and-cancel-button-which-button-tapped
        */
        if saveButton === sender {
            let saveAlert = UIAlertController(title: "Save", message: "Challenge may not be removed after saving.", preferredStyle: UIAlertControllerStyle.alert)
            
            saveAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                print("Handle Ok logic here")
                
                let title = self.titleTextField.text ?? ""
                let photo = self.photoImageView.image
                let descript = self.descriptionTextView.text ?? ""
                
                self.challenge = Challenge(title: title, photo: photo, descript: descript)
                self.challenges.append(self.challenge!)
                self.saveChallenges()
                
                self.titleTextField.text = ""
                self.photoImageView.image = UIImage(named: "defaultPhoto")!
                self.descriptionTextView.text = ""
            }))
            
            saveAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                print("Handle Cancel Logic here")
            }))
            
            present(saveAlert, animated: true, completion: nil)
        }
    }
    
    // MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        print("yes")
        // Hide the keyboard.
        titleTextField.resignFirstResponder()
        descriptionTextView.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: NSCoding
    
    func saveChallenges() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(challenges, toFile: Challenge.ArchiveURL.path)
        if !isSuccessfulSave {
            print("Failed to save challenges...")
        }
    }
    
    func loadChallenges() -> [Challenge]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Challenge.ArchiveURL.path) as? [Challenge]
    }

}
