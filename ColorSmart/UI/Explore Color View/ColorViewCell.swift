//
//  ColorViewCell.swift
//  ColorSmart
//
//  Created by David on 13/06/16.
//  Copyright © 2016 Behr. All rights reserved.
//

import UIKit

class ColorViewCell: UICollectionViewCell {
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
    }
    
}
