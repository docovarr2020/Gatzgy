//
//  UILabelFixing.swift
//  Gatzgy
//
//  Created by Diego Covarrubias on 12/5/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import Foundation

extension UILabel {
    
    func requiredHeight() -> CGFloat{
        
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = self.font
        label.text = self.text
        
        label.sizeToFit()
        
        return label.frame.height
    }
}
