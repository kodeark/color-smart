//
//  CenterViewController.swift
//  ColorSmart
//
//  Created by David on 17/05/16.
//  Copyright © 2016 Behr. All rights reserved.
//

import UIKit

@objc
protocol CenterViewControllerDelegate {
    
    optional func togglePanel()
}

class CenterViewController: UIViewController {
    
    var navigationBarView : NavigationBarView!
    var toolBar : ToolBar!
    var delegate : CenterViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationController?.navigationBarHidden = true
        
        let appDelegate  = UIApplication.sharedApplication().delegate as! AppDelegate
        delegate = appDelegate.containerViewController

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack(sender: AnyObject) {
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func sidePanelOptionSelected(){
        
    }
    
    func addController(controller: UIViewController){
    
        self.view.addSubview(controller.view)
    }
    
    func addNavigationBarOnView(newView : UIView) {
        
        if navigationBarView == nil {
            navigationBarView = NavigationBarView.instanceFromNib()
        }
        
        if navigationBarView.superview == nil {
            
            navigationBarView.delegate = self
            navigationBarView.translatesAutoresizingMaskIntoConstraints = false
            newView.addSubview(navigationBarView)
            
            let horizontalConstraint : NSArray  = NSLayoutConstraint.constraintsWithVisualFormat("|[navigationBarView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["navigationBarView": navigationBarView])
            let verticalConstraint : NSArray = NSLayoutConstraint.constraintsWithVisualFormat("V:|-20-[navigationBarView(40)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["navigationBarView" : navigationBarView])
            
            newView.addConstraints(horizontalConstraint as! [NSLayoutConstraint])
            newView.addConstraints(verticalConstraint as! [NSLayoutConstraint])

        }
        
    }
    
    func addToolBarOnView(newView : UIView) {
        
        if toolBar == nil {
            toolBar = ToolBar.instanceFromNib()
        }
        
        if toolBar.superview == nil {
            
            toolBar.delegate = self
            toolBar.translatesAutoresizingMaskIntoConstraints = false
            newView.addSubview(toolBar)
            
            let horizontalConstraint : NSArray  = NSLayoutConstraint.constraintsWithVisualFormat("|[toolBar]|", options: .DirectionLeadingToTrailing, metrics: nil, views: ["toolBar": toolBar])
            let verticalConstraint : NSArray = NSLayoutConstraint.constraintsWithVisualFormat("V:[navigationBarView][toolBar(123)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["toolBar": toolBar, "navigationBarView" : navigationBarView])
            
            newView.addConstraints(horizontalConstraint as! [NSLayoutConstraint])
            newView.addConstraints(verticalConstraint as! [NSLayoutConstraint])
            
        }
        
    }
    
    func addTopBarOnView(newView : UIView){
    
        addNavigationBarOnView(newView)
        addToolBarOnView(newView)
    }
    
//    func toolBarBottomViewHidden(status : Bool){
//        
//        if toolBar.toolBarHeightConstraint == nil{
//        
//            toolBar.toolBarHeightConstraint = 
//        }
//    
//        if status == true{
//        
//        
//        }else{
//        
//        
//        }
//    }

}

extension CenterViewController: NavigationBarViewDelegate {

    func sliderTapped() {
        
        delegate!.togglePanel!()
    }

}

extension CenterViewController: ToolBarDelegate {
    
    func goBack() {
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}
