//
//  ToolBarView.swift
//  ColorSmart
//
//  Created by David on 24/06/16.
//  Copyright © 2016 Behr. All rights reserved.
//

import UIKit

@objc
protocol ToolBarDelegate {
    
    optional func goBack()
}

class ToolBar: UIView {

    var delegate : ToolBarDelegate?
    var bottomViewHidden : Bool =  true
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var bottomView: UIView!
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
    
    class func instanceFromNib() -> ToolBar {
        return UINib(nibName: "ToolBar", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! ToolBar
    }
    
    
    @IBAction func goBack(sender: AnyObject) {
        
        delegate!.goBack!()

    }
    
    func setBackBtnTitle(title : String){
    
        backBtn.setTitle(" " + title, forState: .Normal)
    }
    
    func showSearchBar(){
    
    
    }
}
