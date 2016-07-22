//
//  Palette.swift
//  ColorSmart
//
//  Created by David on 21/07/16.
//  Copyright © 2016 Behr. All rights reserved.
//

import UIKit

class Palette: RoundedView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var color1: UIView!
    @IBOutlet weak var color2: UIView!
    @IBOutlet weak var color3: UIView!
    @IBOutlet weak var color4: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    func commonInit(){
    
        let nib = UINib(nibName: "Palette", bundle: nil)
        nib.instantiateWithOwner(self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
    }

}
