//
//  MyProjectListViewController.swift
//  ColorSmart
//
//  Created by David on 19/07/16.
//  Copyright © 2016 Behr. All rights reserved.
//

import UIKit

class MyProjectListViewController: CenterViewController{

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var listView: UITableView!
    
    let textCellIdentifier = "TextCell"
    let tableSectionHeaderIdentifier = "TableSectionHeader"
    
    var projectList : NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addTopBarOnView(view)
        toolBar.setBackBtnTitle("My Projects")
        
        let topContainerConstraint : NSArray = NSLayoutConstraint.constraintsWithVisualFormat("V:[toolBar][containerView]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["containerView": containerView, "toolBar" : toolBar])
        view.addConstraints(topContainerConstraint as! [NSLayoutConstraint])

        listView.registerNib(UINib(nibName: "ProjectListTableViewCell", bundle: nil), forCellReuseIdentifier: textCellIdentifier)
        
        createMyProjectList()
        
        listView.dataSource = self
        listView.delegate = self
        //listView.reloadData()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        listView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:
    
    @IBAction func addNewProjectBtnClicked(sender: AnyObject) {
        
        let projectNameViewCtrl = MyProjectNameViewController(nibName: "MyProjectNameViewController", bundle: nil)
        self.navigationController?.pushViewController(projectNameViewCtrl, animated: true)
        
    }

    // MARK:
    
    func createMyProjectList(){
    
        var myProject = MyProject()
        myProject.name = "Den: Blue Version"
        projectList.addObject(myProject)
        
        myProject = MyProject()
        myProject.name = "New Kitchen"
        projectList.addObject(myProject)
        
        myProject = MyProject()
        myProject.name = "Guest Bathroom"
        projectList.addObject(myProject)
    }
    
    func addProject(project : MyProject){
        
        projectList.addObject(project)
        listView.reloadData()
    }
    
}

extension MyProjectListViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return projectList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier) as? ProjectListTableViewCell
        if cell != nil{
            
            let myProject = projectList[indexPath.row] as? MyProject
            cell!.titleLbl!.text = myProject!.name!.capitalizedString
        }
        return cell!
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
    
        if editingStyle == .Delete{
        
            self.projectList.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        }
    }
    
}

extension MyProjectListViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String?{
    
        return "DELETE"
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }

}
