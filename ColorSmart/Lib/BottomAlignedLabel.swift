//
//  BottomAlignedLabel.swift
//  ColorSmart
//
//  Created by David on 15/07/16.
//  Copyright © 2016 Behr. All rights reserved.
//

import UIKit

class BottomAlignedLabel: UILabel {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func drawTextInRect(rect: CGRect) {
        let height = self.sizeThatFits(rect.size).height
        let y = rect.origin.y + rect.height - height
        super.drawTextInRect(CGRect(x: rect.origin.x, y: y, width: rect.width, height: height))
    }

}
