//
//  MyProjectDetailSectionHeaderView.swift
//  ColorSmart
//
//  Created by David on 20/07/16.
//  Copyright © 2016 Behr. All rights reserved.
//

import UIKit

class MyProjectDetailSectionHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var sectionLbl: UILabel!
    @IBOutlet weak var toggleBtn: UIButton!
    @IBOutlet weak var expandCollapseView: UIImageView!
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override var contentView: UIView{
    
        return self.subviews[0]
    }
    

}
