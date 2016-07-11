//
//  SidePanelViewController.swift
//  ColorSmart
//
//  Created by David on 17/05/16.
//  Copyright © 2016 Behr. All rights reserved.
//

import UIKit

@objc
protocol SidePanelViewControllerDelegate {
    
    optional func sidePanelOptionSelected()
    optional func sidePanelClosed()
}

class SidePanelViewController: UIViewController {
    
    @IBOutlet weak var leftPanelView: UIView!

    @IBOutlet weak var backgndView: UIView!
    
    @IBOutlet weak var treeView: UIView!
    
    var leftPanelCollapseOffset: CGFloat!

    
    @IBAction func sliderClose(sender: AnyObject) {
        
        delegate?.sidePanelClosed!()
    }
    
    var delegate: SidePanelViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        leftPanelCollapseOffset = (CGRectGetWidth(leftPanelView.frame) * -1)
        
        leftPanelView.frame.origin.x =  leftPanelCollapseOffset!
        self.backgndView.alpha = 0.0
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func show(shouldExpand: Bool, completion: ((Bool) -> Void)! = nil) {
        if (shouldExpand) {
            
            animateLeftPanel(0, alphaValue: 0.9)
            
        } else {
            
            animateLeftPanel(leftPanelCollapseOffset, alphaValue: 0.0, completion: completion)
        }
    }

    
    func animateLeftPanel(targetPosition: CGFloat, alphaValue: CGFloat, completion: ((Bool) -> Void)! = nil) {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
            self.leftPanelView.frame.origin.x = targetPosition
            self.backgndView.alpha = alphaValue
            }, completion: completion)
    }
    
    
}