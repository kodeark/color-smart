//
//  RoundedView.swift
//  ColorSmart
//
//  Created by David on 6/07/16.
//  Copyright © 2016 Behr. All rights reserved.
//

import UIKit

class RoundedView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    let corner_radius : CGFloat = 12.0
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        initialise()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        initialise()
        
    }
    
    func initialise(){
        
        self.layer.cornerRadius  = corner_radius;
        self.clipsToBounds = true
        self.layer.masksToBounds = true        
    }


}
