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
            
            navigationBarView.frame = CGRect(x: 0.0, y: 20, width: CGRectGetWidth(newView.bounds), height: 44.0)
            navigationBarView.delegate = self
            navigationBarView.autoresizingMask = .FlexibleWidth
            newView.addSubview(navigationBarView)
        }
        
    }
    
    func addToolBarOnView(newView : UIView) {
        
        if toolBar == nil {
            toolBar = ToolBar.instanceFromNib()
        }
        
        if toolBar.superview == nil {
            
            var frame = toolBar.frame
            frame.origin.y = CGRectGetMaxY(navigationBarView.frame)
            frame.size.width = CGRectGetWidth(newView.bounds)
            toolBar.frame = frame

            toolBar.delegate = self
            toolBar.autoresizingMask = .FlexibleWidth
            newView.addSubview(toolBar)
            
        }
        
    }
    
    func addTopBarOnView(newView : UIView){
    
        addNavigationBarOnView(newView)
        addToolBarOnView(newView)
    }

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
