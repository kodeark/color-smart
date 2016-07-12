//
//  CenterAlignedButton.swift
//  ColorSmart
//
//  Created by David on 12/07/16.
//  Copyright © 2016 Behr. All rights reserved.
//

import UIKit

class CenterAlignedButton: UIButton {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.titleLabel?.textAlignment = .Center
    }

}
