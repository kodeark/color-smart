//
//  SearchListViewCell.swift
//  ColorSmart
//
//  Created by David on 13/07/16.
//  Copyright © 2016 Behr. All rights reserved.
//

import UIKit

class SearchListViewCell: UITableViewCell {

    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var mainLbl: UILabel!
    @IBOutlet weak var subLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        colorView.layer.cornerRadius = 10.0
        colorView.layer.masksToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    
}
