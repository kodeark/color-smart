//
//  RoundedButton.swift
//  ColorSmart
//
//  Created by David on 29/06/16.
//  Copyright © 2016 Behr. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {

    let corner_radius : CGFloat = 10.0
    
    
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
        //self.backgroundColor = UIColor.init(hexString: "#656D78")

    }
    
}
