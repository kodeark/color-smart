//
//  TreeTableViewCell.swift
//  ColorSmart
//
//  Created by David on 25/05/16.
//  Copyright © 2016 Behr. All rights reserved.
//

import UIKit

class TreeTableViewCell : UITableViewCell {

    @IBOutlet private weak var dropDownButton: UIButton!
    @IBOutlet private weak var customTitleLabel: UILabel!

    private var dropDownButtonHidden : Bool {
        get {
            return dropDownButton.hidden;
        }
        set {
            dropDownButton.hidden = newValue;
        }
    }

    override func awakeFromNib() {
        selectedBackgroundView? = UIView.init()
        selectedBackgroundView?.backgroundColor = UIColor.clearColor()
        
        self.backgroundColor = UIColor.clearColor()
        
    }


    func setup(withTitle title: String, level : Int, dropDownButtonHidden: Bool) {
        customTitleLabel.text = title
        self.dropDownButtonHidden = dropDownButtonHidden

        let left = 20.0 + 20.0 * CGFloat(level)
        self.customTitleLabel.frame.origin.x = left
    }


}