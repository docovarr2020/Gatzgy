//
//  JournalViewCell.swift
//  Gatzgy
//
//  Created by Diego Covarrubias on 12/1/16.
//  Copyright © 2016 Diego Covarrubias. All rights reserved.
//
/*
 Basic layout for this file and core pieces of code courtesy of: https://developer.apple.com/library/content/referencelibrary/GettingStarted/DevelopiOSAppsSwift/index.html#//apple_ref/doc/uid/TP40015214-CH2-SW1
 */

import UIKit


class JournalViewCell: UITableViewCell {
    // MARK: Properties
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
