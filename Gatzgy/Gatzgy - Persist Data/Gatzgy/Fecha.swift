//
//  Fecha.swift
//  Gatzgy
//
//  Created by Diego Covarrubias on 12/5/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//
/*
 Basic layout for this file and core pieces of code courtesy of: https://developer.apple.com/library/content/referencelibrary/GettingStarted/DevelopiOSAppsSwift/index.html#//apple_ref/doc/uid/TP40015214-CH2-SW1
 */

import Foundation

class Fecha: NSObject, NSCoding {
    // MARK: Properties
    
    var fecha: String
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("fecha")
    
    // MARK: Types
    
    struct PropertyKey {
        static let fechaKey = "fecha"
    }
    
    // MARK: Initialization
    
    init?(fecha: String) {
        // Initialize stored properties.
        self.fecha = fecha
        
        super.init()
        
        // Initialization should fail if there is no name or if the rating is negative.
        if fecha.isEmpty {
            return nil
        }
    }
    
    // MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(fecha, forKey: PropertyKey.fechaKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let fecha = aDecoder.decodeObject(forKey: PropertyKey.fechaKey) as! String
        
        // Must call designated initializer.
        self.init(fecha: fecha)
    }
    
}
