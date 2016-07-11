//
//  NavigationBarView.swift
//  ColorSmart
//
//  Created by David on 26/05/16.
//  Copyright © 2016 Behr. All rights reserved.
//

import UIKit

@objc
protocol NavigationBarViewDelegate {
    
    optional func sliderTapped()
}

class NavigationBarView: UIView {
    
    var delegate : NavigationBarViewDelegate?

    @IBAction func sliderBtnTapped(sender: AnyObject) {
        
        delegate!.sliderTapped!()
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    class func instanceFromNib() -> NavigationBarView {
        return UINib(nibName: "NavigationBarView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! NavigationBarView
    }

}
