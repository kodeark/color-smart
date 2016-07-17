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
    optional func clearSearch()
    optional func searchBarTextDidBeginEditing(searchBar: CustomSearchBar!)
    optional func searchBarTextDidEndEditing(searchBar: CustomSearchBar!)
    optional func searchBarSearchButtonClicked(searchBar: CustomSearchBar!)

}

class ToolBar: UIView {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var backBtn: UIButton!

    var delegate : ToolBarDelegate?
    var searchBar : CustomSearchBar? = nil
    var bottomViewHidden : Bool =  true
    var heightConstraint : NSLayoutConstraint?
    
    class func instanceFromNib() -> ToolBar {
        return UINib(nibName: "ToolBar", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! ToolBar
    }
    
    @IBAction func goBack(sender: AnyObject) {
        
        delegate!.goBack!()
    }
    
    func setBackBtnTitle(title : String){
    
        backBtn.setTitle(" " + title, forState: .Normal)
    }
    
    func addSearchBar(){
    
        let searchBarMargin : CGFloat = 10.0
        searchBar = CustomSearchBar.init(frame: CGRectMake(searchBarMargin, searchBarMargin, bottomView.bounds.width - searchBarMargin*2, bottomView.bounds.height - searchBarMargin*2))
        searchBar!.translatesAutoresizingMaskIntoConstraints = false
        searchBar?.delegate = self
        bottomView.addSubview(searchBar!)

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
    
    func showSearchBar(){
    
        if searchBar == nil{
            
            addSearchBar()
        }
    }
    
}

extension ToolBar: CustomSearchBarDelegate {
    
    func searchBarClearButtonClicked(searchBar: CustomSearchBar!) {
        
        delegate?.clearSearch!()
    }
    
    func searchBarTextDidEndEditing(searchBar: CustomSearchBar!) {
        
    }
   
    func searchBarSearchButtonClicked(searchBar: CustomSearchBar!) {
        
        delegate?.searchBarSearchButtonClicked!(searchBar)
    }
    
    func searchBarTextDidBeginEditing(searchBar: CustomSearchBar!) {
        
        delegate?.searchBarTextDidBeginEditing!(searchBar)
    }

}
