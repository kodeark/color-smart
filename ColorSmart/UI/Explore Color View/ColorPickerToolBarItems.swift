//
//  ColorPickerToolBarItems.swift
//  ColorSmart
//
//  Created by David on 11/07/16.
//  Copyright © 2016 Behr. All rights reserved.
//

import UIKit

@objc
protocol ColorPickerToolBarItemsDelegate {
    
    optional func resizeImage()
    optional func replaceImage()
}

class ColorPickerToolBarItems: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var delegate : ColorPickerToolBarItemsDelegate?
    
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
    
    class func instanceFromNib() -> ColorPickerToolBarItems {
        return UINib(nibName: "ColorPickerToolBarItems", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! ColorPickerToolBarItems
    }

    
    @IBAction func replaceImage(sender: AnyObject) {
        
        delegate?.replaceImage!()
    }

    @IBAction func resizeImage(sender: AnyObject) {
        
        delegate?.resizeImage!()

    }
}
