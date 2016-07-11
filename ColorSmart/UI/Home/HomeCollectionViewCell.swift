//
//  HomeCollectionViewCell.swift
//  ColorSmart
//
//  Created by David on 26/05/16.
//  Copyright © 2016 Behr. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
    }

}
