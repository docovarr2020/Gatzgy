//
//  DailyChallengeViewController.swift
//  Gatzgy
//
//  Created by Diego Covarrubias on 12/4/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//
/*
 Basic layout for this file and core pieces of code courtesy of: https://developer.apple.com/library/content/referencelibrary/GettingStarted/DevelopiOSAppsSwift/index.html#//apple_ref/doc/uid/TP40015214-CH2-SW1
 */

import UIKit

class DailyChallengeViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var challenges = [Challenge]()
    var currentChallenge: Challenge?
    var fecha = [Fecha]()
    var challengeNumber = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Add border to TextView
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.borderColor = UIColor.black.cgColor
        
        // Resize the title Label
        titleLabel.bounds.size.height = titleLabel.requiredHeight()
        
        /*
         Navigation Bar code from this source: https://www.appcoda.com/sidebar-menu-swift/
         */
        
        // Initial set up for navigation bar.
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        /*
         All code concerning UserDefaults is based off of this: http://stackoverflow.com/questions/27642492/saving-and-loading-an-integer-on-xcode-swift
        */
        // Set Challenge Number from memory
        let defaults: UserDefaults = UserDefaults.standard
        if defaults.value(forKey: "challengeNumber") != nil {
            challengeNumber = (defaults.value(forKey: "challengeNumber") as? Int)!
        }
        // Load any saved challenges, otherwise load sample data.
        if let savedChallenges = loadChallenges() {
            challenges += savedChallenges

        } else {
            // Load the sample data.
            loadSampleChallenges()
        }
        print(challenges)
        
        // Load any saved fecha, otherwise load random challenge.
        if (loadFecha() != nil) {
            
            fecha += loadFecha()!
            /*
             Pretty much all of the code concerning time is based off of this stackoverflow page:
             http://stackoverflow.com/questions/25511945/swift-alert-view-ios8-with-ok-and-cancel-button-which-button-tapped
            */
            // Turns a string into a date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            let pastFecha = dateFormatter.date(from: fecha[0].fecha)
            
            // Gets current date
            let calendar = Calendar.autoupdatingCurrent
            let components = calendar.dateComponents([.day, .month, .year], from: Date())
            
            // Check to see if it is a new day.
            let today = calendar.date(from: components)
            
            if pastFecha! < today! {
                print("New Day")
                
                // Makes date a string
                if let componentsBasedFecha = calendar.date(from: components) {
                    let today = dateFormatter.string(from: componentsBasedFecha)
                    let newFecha = Fecha(fecha: today)
                    
                    // Add new fecha to fecha array
                    fecha.append(newFecha!)
                    
                    // Delete the pastFecha from the array
                    fecha.remove(at: 0)
                    saveFecha()
                    
                    // Create random Number for Challenge
                    challengeNumber = Int(arc4random_uniform(UInt32(challenges.count)))
                    
                    // Save the Number for future use
                    let defaults: UserDefaults = UserDefaults.standard
                    defaults.set(challengeNumber, forKey: "challengeNumber")
                    defaults.synchronize()
                    
                    // Update currentChallenge
                    let currentChallenge = challenges[challengeNumber]
                    
                    titleLabel.text = currentChallenge.title
                    photoImageView.image = currentChallenge.photo
                    descriptionTextView.text = currentChallenge.descript
                }
            } else {
                // pastFecha is not a new day
                print("Not a new Day")
                
                // Make sure the current Challenge Number is not nil.
                if challengeNumber != nil {
                    let currentChallenge = challenges[challengeNumber]
                    
                    titleLabel.text = currentChallenge.title
                    photoImageView.image = currentChallenge.photo
                    descriptionTextView.text = currentChallenge.descript
                }
                else{
                    let currentChallenge = challenges[0]
                    
                    titleLabel.text = currentChallenge.title
                    photoImageView.image = currentChallenge.photo
                    descriptionTextView.text = currentChallenge.descript
                }
            }
        } else {
            
            // Gets current date
            let calendar = Calendar.autoupdatingCurrent
            let components = calendar.dateComponents([.day, .month, .year], from: Date())
            
            // Makes date a string
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            if let componentsBasedFecha = calendar.date(from: components) {
                let today = dateFormatter.string(from: componentsBasedFecha)
                let newFecha = Fecha(fecha: today)!
                
                // Add new fecha to fecha array
                fecha.append(newFecha)
                saveFecha()
            }
            // Configure Scene to show the first challenge
            let currentChallenge = challenges[0]
            
            titleLabel.text = currentChallenge.title
            photoImageView.image = currentChallenge.photo
            descriptionTextView.text = currentChallenge.descript
        }
    }
    
    func loadSampleChallenges() {
        challenges += sampleChallenges.defaultChallenges
        saveChallenges()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
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
    
    func saveFecha() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(fecha, toFile: Fecha.ArchiveURL.path)
        if !isSuccessfulSave {
            print("Failed to save Fecha...")
        }
    }
    
    func loadFecha() -> [Fecha]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Fecha.ArchiveURL.path) as? [Fecha]
    }

}
