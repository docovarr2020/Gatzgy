//
//  JournalViewController.swift
//  Gatzgy
//
//  Created by Diego Covarrubias on 12/1/16.
//  Copyright © 2016 Diego Covarrubias. All rights reserved.
//
/*
 Basic layout for this file and core pieces of code courtesy of: https://developer.apple.com/library/content/referencelibrary/GettingStarted/DevelopiOSAppsSwift/index.html#//apple_ref/doc/uid/TP40015214-CH2-SW1
 */

import UIKit

class JournalViewController: UITableViewController {
    // MARK: Properties
    
    var entries = [Entry]()
    @IBOutlet weak var menuButton: UIBarButtonItem!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
         Navigationbar Code from this source: https://www.appcoda.com/sidebar-menu-swift/
         */
        
        // Set up for the navigation bar.

        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        
        // Load any saved entries, otherwise load sample data.
        if let savedEntries = loadEntries() {
            entries += savedEntries
        } else {
            // Load the sample data.
            loadSampleEntries()
        }
    }
    
    func loadSampleEntries() {
        let photo1 = UIImage(named: "youtube binge")!
        let entry1 = Entry(title: "YouTube Film Festival", photo: photo1, descript: "Jan and I spent all night watching random YouTube videos. 9 hours!! It was pretty fun, but I think this face says it all: Never again.")!
        
        let photo2 = UIImage(named: "giant steak")!
        let entry2 = Entry(title: "Steak-zilla", photo: photo2, descript: "This thing was huge! I swear it weighed more than I did as a newborn. Did I finish? No. Did I eat more of it than I should have? Well ... the app told me to. #LivinLikeGatzgy")!
        
        let photo3 = UIImage(named: "billy ray")!
        let entry3 = Entry(title: "I HATE country", photo: photo3, descript: "Just spent the last hour torturing myself with this myself with this. Why Billy Ray? Why?!? I think I'll have flashbacks everytime I see a mullet.")!
        
        entries += [entry1, entry2, entry3]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "JournalViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! JournalViewCell
        
        // Fetches the appropriate entry for the data source layout.
        let entry = entries[indexPath.row]
        
        cell.nameLabel.text = entry.title
        cell.photoImageView.image = entry.photo
        cell.descriptionLabel.text = entry.descript
        
        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            entries.remove(at: indexPath.row)
            saveEntries()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowDetail" {
            let entryDetailViewController = segue.destination as! EntryViewController

            // Get the cell that generated this segue.
            if let selectedEntryCell = sender as? JournalViewCell {
                let indexPath = tableView.indexPath(for: selectedEntryCell)!
                let selectedEntry = entries[indexPath.row]
                entryDetailViewController.entry = selectedEntry
            }
        }
        else if segue.identifier == "AddItem" {
            print("Adding new entry.")
        }
    }
    /*
        All code concerning the unwind is based off of code from https://www.andrewcbancroft.com/2015/12/18/working-with-unwind-segues-programmatically-in-swift/
    */

    @IBAction func unwindToEntryList(_ sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? EntryViewController, let entry = sourceViewController.entry {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing entry.
                entries[selectedIndexPath.row] = entry
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                // Add a new entry.
                let newIndexPath = IndexPath(row: entries.count, section: 0)
                entries.append(entry)
                tableView.insertRows(at: [newIndexPath], with: .bottom)
            }
            // Save the entries.
            saveEntries()
        }
    }
    
    // MARK: NSCoding
    
    func saveEntries() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(entries, toFile: Entry.ArchiveURL.path)
        if !isSuccessfulSave {
            print("Failed to save entries...")
        }
    }
    
    func loadEntries() -> [Entry]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Entry.ArchiveURL.path) as? [Entry]
    }
}
