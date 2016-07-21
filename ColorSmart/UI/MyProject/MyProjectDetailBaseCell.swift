//
//  MyProjectDetailBaseCell.swift
//  ColorSmart
//
//  Created by David on 21/07/16.
//  Copyright © 2016 Behr. All rights reserved.
//

import UIKit

protocol MyProjectDetailBaseCellDelegate {

    func moveToTrash(parentCell: MyProjectDetailBaseCell)

}

class MyProjectDetailBaseCell: UITableViewCell {

    var delegate: MyProjectDetailBaseCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
