//
//  ProjectDetailViewController.swift
//  ColorSmart
//
//  Created by David on 19/07/16.
//  Copyright © 2016 Behr. All rights reserved.
//

import UIKit

class ProjectDetailViewController: CenterViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var listView: UITableView!
    @IBOutlet var footerView: UIView!

    var myProject : MyProject?
    var collapsedSections = NSMutableIndexSet.init()
    
    let textCellIdentifier = "TextCell"
    let sectionHeaderWithButtonIdentifier = "SectionHeaderWithButton"
    let sectionHeaderIdentifier = "SectionHeader"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addTopBarOnView(view)
        toolBar.setBackBtnTitle("My Projects")
        
        let topContainerConstraint : NSArray = NSLayoutConstraint.constraintsWithVisualFormat("V:[toolBar][containerView]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["containerView": containerView, "toolBar" : toolBar])
        view.addConstraints(topContainerConstraint as! [NSLayoutConstraint])
        
        listView.tableFooterView = footerView
        
        listView.registerNib(UINib(nibName: "ProjectListTableViewCell", bundle: nil), forCellReuseIdentifier: textCellIdentifier)
        
        listView.delegate = self
        listView.dataSource = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createMyProjectDetail(){
        
        var colorArray : [Color] = []
        
        //Color
        var color = Color()
        color.title = "Timeless Red"
        color.subTitle = "HDC-CL-01"
        color.value = UIColor.redColor()
        colorArray.append(color)
        
        //Color
        color = Color()
        color.title = "Misty Grey"
        color.subTitle = "HDC-CL-01"
        color.value = UIColor.redColor()
        colorArray.append(color)
    
        //Cordinate palette
        color = Color()
        
        let palette = CordinatedPalette()
        color = Color()
        color.title = "Timeless Red"
        color.subTitle = "HDC-CL-01"
        color.value = UIColor.redColor()
        palette.color1 = color
        
        color = Color()
        color.title = "Misty Grey"
        color.subTitle = "HDC-CL-01"
        color.value = UIColor.redColor()
        palette.color1 = color
        
        color = Color()
        color.title = "Clay"
        color.subTitle = "HDC-CL-01"
        color.value = UIColor.redColor()
        palette.color1 = color
        
        color = Color()
        color.title = "Golden Yellow"
        color.subTitle = "HDC-CL-01"
        color.value = UIColor.redColor()
        palette.color1 = color
        
        color.cordinatedPalette = palette
        colorArray.append(color)
        
        myProject?.detail.append(colorArray)
        
        var paintEstimationArray : [PaintEstimation] = []
        
        var estimation = PaintEstimation()
        estimation.areaName = "Walls"
        estimation.quantity = 2
        paintEstimationArray.append(estimation)
        
        estimation = PaintEstimation()
        estimation.areaName = "Doors"
        estimation.quantity = 2
        paintEstimationArray.append(estimation)
        
        estimation = PaintEstimation()
        estimation.areaName = "Tim"
        estimation.quantity = 2
        paintEstimationArray.append(estimation)
        
        estimation = PaintEstimation()
        estimation.areaName = "Celing"
        estimation.quantity = 2
        paintEstimationArray.append(estimation)
        
        myProject?.detail.append(paintEstimationArray)
    }
    
}

// MARK:

extension ProjectDetailViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return (myProject?.detail.count)!
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == ((myProject?.detail.count)! - 1){
        
            let paintEstimationList = myProject?.detail[section]
            return (paintEstimationList!.count)!
        }
        
        if !collapsedSections.contains(section){
            
            myProject?.detail[section].count
        }
    
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier)
        return cell!
        
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionView : MyProjectDetailSectionHeader?
        
        if section == ((myProject?.detail.count)! - 1){
            
            sectionView = tableView.dequeueReusableHeaderFooterViewWithIdentifier(sectionHeaderIdentifier) as? MyProjectDetailSectionHeader
            
        }else{
        
            sectionView = tableView.dequeueReusableHeaderFooterViewWithIdentifier(sectionHeaderWithButtonIdentifier) as? MyProjectDetailSectionHeader
            sectionView?.sectionLbl.text = myProject?.detail[section].key

        }
        return sectionView!
    }
    
}

// MARK:
extension ProjectDetailViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String?{
        
        return "DELETE"
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
}
