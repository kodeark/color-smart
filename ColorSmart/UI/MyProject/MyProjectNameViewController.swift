//
//  MyProjectNameViewController.swift
//  ColorSmart
//
//  Created by David on 19/07/16.
//  Copyright © 2016 Behr. All rights reserved.
//

import UIKit

class MyProjectNameViewController: CenterViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameTxtField: UITextField!
    
    var projectName : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addTopBarOnView(view)
        toolBar.setBackBtnTitle("My Projects")
        
        let topContainerConstraint : NSArray = NSLayoutConstraint.constraintsWithVisualFormat("V:[toolBar][containerView]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["containerView": containerView, "toolBar" : toolBar])
        view.addConstraints(topContainerConstraint as! [NSLayoutConstraint])

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func continueClicked(sender: AnyObject) {
        
        let myProject = MyProject()
        myProject.name = projectName
        
        let count = self.navigationController?.viewControllers.count
        
        let projectListCtrl = self.navigationController?.viewControllers[count! - 2] as? MyProjectListViewController
        projectListCtrl?.addProject(myProject)
        
        navigationController?.popViewControllerAnimated(true)
        
    }
   
}

extension MyProjectNameViewController : UITextFieldDelegate{

    func textFieldShouldReturn(textField: UITextField) -> Bool{
    
        projectName = textField.text
        textField.resignFirstResponder()
        
        return true
    }

}
