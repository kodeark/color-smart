//
//  MyProjectDetailColorTableViewCell.swift
//  ColorSmart
//
//  Created by David on 21/07/16.
//  Copyright © 2016 Behr. All rights reserved.
//

import UIKit

class ColorInfoCell: MyProjectDetailBaseCell {

    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var listView: UITableView!
    
    @IBOutlet weak var mainLbl: UILabel!
    @IBOutlet weak var subLbl: UILabel!
    @IBOutlet weak var colorInfoTopMarginConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func trashBtnClicked(sender: AnyObject) {
        
        delegate.moveToTrash(self)
    }
}
