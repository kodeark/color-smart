//
//  PaintEstimationCell.swift
//  ColorSmart
//
//  Created by David on 21/07/16.
//  Copyright © 2016 Behr. All rights reserved.
//

import UIKit

class PaintEstimationSubCell: MyProjectDetailBaseCell {

    @IBOutlet weak var surfaceName: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var quantity: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
