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

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var backBtn: UIButton!

    var delegate : ToolBarDelegate?
    var bottomViewHidden : Bool =  true
    
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
    
        let searchBar = SSSearchBar.init(frame: CGRectMake(0.0, 0.0, bottomView.bounds.width, bottomView.bounds.height))
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        bottomView.addSubview(searchBar)
    }
    
    func addRightBarButtonItems(toolBarItems : UIView){
        
        toolBarItems.translatesAutoresizingMaskIntoConstraints = false
        topView.addSubview(toolBarItems)
        
        let trailingConstraint = NSLayoutConstraint.init(item: topView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem:toolBarItems , attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 0)
        
        let topConstraint = NSLayoutConstraint.init(item: topView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem:toolBarItems , attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0)
        
        let bottomConstraint = NSLayoutConstraint.init(item: topView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem:toolBarItems , attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0)
        
        topView.addConstraint(trailingConstraint)
        topView.addConstraint(topConstraint)
        topView.addConstraint(bottomConstraint)

    }
}
