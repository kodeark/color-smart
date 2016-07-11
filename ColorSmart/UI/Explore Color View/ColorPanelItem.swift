//
//  ColorPanel.swift
//  ColorSmart
//
//  Created by David on 7/07/16.
//  Copyright © 2016 Behr. All rights reserved.
//

import UIKit

class ColorPanelItem: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var delegate : ColorPanelDelegate?
    
    class func instanceFromNib() -> ColorPanelItem {
        return UINib(nibName: "ColorPanelItem", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! ColorPanelItem
    }

}
