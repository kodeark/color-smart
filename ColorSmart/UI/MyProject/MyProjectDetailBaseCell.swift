//
//  MyProjectDetailBaseCell.swift
//  ColorSmart
//
//  Created by David on 21/07/16.
//  Copyright © 2016 Behr. All rights reserved.
//

import UIKit

protocol MyProjectDetailBaseCellDelegate {

    func deleteItem(index : NSIndexPath)

}

class MyProjectDetailBaseCell: UITableViewCell {

    var delegate: MyProjectDetailBaseCellDelegate!
    var indexPath : NSIndexPath = NSIndexPath(forRow: 0, inSection: 0)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
