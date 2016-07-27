//
//  ContainerViewController.swift
//  ColorSmart
//
//  Created by David on 17/05/16.
//  Copyright © 2016 Behr. All rights reserved.
//

import UIKit
import MBProgressHUD

enum SlideOutState {
    case Collapsed
    case LeftPanelExpanded
}

class ContainerViewController: UIViewController {
    
    var centerNavigationController : UINavigationController!
    var centerViewController : HomeViewController!
    var leftViewController: SidePanelViewController?
    
    var treeViewController: TreeViewController?

    var currentState: SlideOutState = .Collapsed
    
    var appData  : AppData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        centerViewController = HomeViewController(nibName: "HomeViewController", bundle: nil)
        
        // wrap the centerViewController in a navigation controller, so we can push views to it
        // and display bar button items in the navigation bar
        centerNavigationController = UINavigationController(rootViewController: centerViewController)
        view.addSubview(centerNavigationController.view)
        addChildViewController(centerNavigationController)
        
        centerNavigationController.didMoveToParentViewController(self)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ContainerViewController: CenterViewControllerDelegate , SidePanelViewControllerDelegate {

    func addLeftPanelViewController() {
        if (leftViewController == nil) {
            leftViewController = SidePanelViewController()
        }
        
        addChildSidePanelController(leftViewController!)

        leftViewController?.delegate = self
    }
    
    func addChildSidePanelController(sidePanelController: SidePanelViewController) {
        
        view.insertSubview(sidePanelController.view, atIndex: 1)
        
        view.addConstraintsWithFormat("H:|[v0]|", views: sidePanelController.view)
        view.addConstraintsWithFormat("V:|[v0]|", views: sidePanelController.view)
        
        addChildViewController(sidePanelController)
        sidePanelController.didMoveToParentViewController(self)
        
        if treeViewController == nil {
            
            treeViewController  = TreeViewController.init()
            sidePanelController.treeView.addSubview(treeViewController!.view)
            sidePanelController.addChildViewController(treeViewController!)
            
            let frame = sidePanelController.treeView.bounds
            treeViewController!.view.frame = frame

        }
       
    }
    
    func togglePanel() {
        
        let notAlreadyExpanded = (currentState != .LeftPanelExpanded)
        
        if notAlreadyExpanded {
            
            addLeftPanelViewController()
            currentState = .LeftPanelExpanded
            leftViewController!.show(notAlreadyExpanded)
            
        }else{
        
            leftViewController!.show(notAlreadyExpanded) { finished in
                self.currentState = .Collapsed
                
                self.leftViewController!.view.removeFromSuperview()
                self.leftViewController?.removeFromParentViewController()
            }
        }
        
    }
    
    func sidePanelClosed(){
        
        togglePanel()
    }
    
    func sidePanelOptionSelected(){
        
        centerViewController.sidePanelOptionSelected()
    }
    
    func showLoadingHUD() {
        let hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
        hud.label.text = "Loading..."
    }
    
    func hideLoadingHUD() {
        MBProgressHUD.hideHUDForView(view, animated: true)
    }
}
