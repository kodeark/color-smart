//
//  InspirationViewController.swift
//  ColorSmart
//
//  Created by David on 14/07/16.
//  Copyright © 2016 Behr. All rights reserved.
//

import UIKit

class InspirationViewController: CenterViewController {

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet var showCaseView: UIView!
    @IBOutlet weak var showCaseTypeSegmentedCtrl: ADVSegmentedControl!
    
    @IBOutlet weak var showCaseSubTypeSegmentedCtrl: ADVSegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addTopBarOnView(view)
        toolBar.setBackBtnTitle("INSPIRATION")
        
        let topContainerConstraint = NSLayoutConstraint.init(item: containerView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: toolBar, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0)
        view.addConstraint(topContainerConstraint)
        
        setupShowCaseView()//TODO:Need to implement condition based addition of showcase or scrapbook.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setupShowCaseView(){
    
        showCaseView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(showCaseView)
        
        let topContainerConstraint = NSLayoutConstraint.init(item: contentView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: showCaseView, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0)
        contentView.addConstraint(topContainerConstraint)
        
        let bottomContainerConstraint = NSLayoutConstraint.init(item: contentView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: showCaseView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0)
        contentView.addConstraint(bottomContainerConstraint)
        
        let leadingContainerConstraint = NSLayoutConstraint.init(item: contentView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: showCaseView, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0)
        contentView.addConstraint(leadingContainerConstraint)
        
        let trailingContainerConstraint = NSLayoutConstraint.init(item: contentView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: showCaseView, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 0)
        contentView.addConstraint(trailingContainerConstraint)
        
        let font = UIFont(name: "OpenSans-Semibold", size: 14.0)
        let selectedIndex = 0
        
        showCaseTypeSegmentedCtrl.items = ["INTERIOR SHOWCASE", "EXTERIOR SHOWCASE"]
        showCaseTypeSegmentedCtrl.font = font
        showCaseTypeSegmentedCtrl.selectedIndex = selectedIndex
        showCaseTypeSegmentedCtrl.addTarget(self, action: #selector(InspirationViewController.showCaseTypeChanged(_:)), forControlEvents: .ValueChanged)
        
        showCaseSubTypeSegmentedCtrl.items = ["ROOM", "STYLE", "COLOR"]
        showCaseSubTypeSegmentedCtrl.font = font
        showCaseSubTypeSegmentedCtrl.selectedIndex = selectedIndex
        showCaseSubTypeSegmentedCtrl.addTarget(self, action: #selector(InspirationViewController.showCaseTypeChanged(_:)), forControlEvents: .ValueChanged)

    }
    
    
     @IBAction func showCaseTypeChanged(sender: AnyObject){
    
    
    }

}
