//
//  Entry.swift
//  Gatzgy
//
//  Created by Diego Covarrubias on 12/1/16.
//  Copyright © 2016 Diego Covarrubias. All rights reserved.
//
/*
 Basic layout for this file and core pieces of code courtesy of: https://developer.apple.com/library/content/referencelibrary/GettingStarted/DevelopiOSAppsSwift/index.html#//apple_ref/doc/uid/TP40015214-CH2-SW1
 */

import UIKit

class Entry: NSObject, NSCoding {
    // MARK: Properties
    
    var title: String
    var photo: UIImage?
    var descript: String?
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("entries")
    
    // MARK: Types
    
    struct PropertyKey {
        static let titleKey = "title"
        static let photoKey = "photo"
        static let descriptionKey = "descript"
    }

    // MARK: Initialization
    
    init?(title: String, photo: UIImage?, descript: String?) {
        // Initialize stored properties.
        self.title = title
        self.photo = photo
        self.descript = descript
        
        super.init()
        
        // Initialization should fail if there is no name or if the rating is negative.
        if title.isEmpty {
            return nil
        }
    }
    
    // MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: PropertyKey.titleKey)
        aCoder.encode(photo, forKey: PropertyKey.photoKey)
        aCoder.encode(descript, forKey: PropertyKey.descriptionKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let title = aDecoder.decodeObject(forKey: PropertyKey.titleKey) as! String
        
        // Because photo is an optional property of Entry, use conditional cast.
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photoKey) as? UIImage
        
        let descript = aDecoder.decodeObject(forKey: PropertyKey.descriptionKey) as? String
        
        // Must call designated initializer.
        self.init(title: title, photo: photo, descript: descript)
    }

}
