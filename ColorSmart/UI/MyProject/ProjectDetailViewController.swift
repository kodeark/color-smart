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
    
    let colorCellIdentifier = "ColorCell"
    let paintEstimationCellIdentifier = "PaintEstimationCellIdentifier"

    let sectionHeaderWithButtonIdentifier = "SectionHeaderWithButton"
    let sectionHeaderIdentifier = "SectionHeader"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addTopBarOnView(view)
        toolBar.setBackBtnTitle("My Projects")
        
        let topContainerConstraint : NSArray = NSLayoutConstraint.constraintsWithVisualFormat("V:[toolBar][containerView]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["containerView": containerView, "toolBar" : toolBar])
        view.addConstraints(topContainerConstraint as! [NSLayoutConstraint])
        
        listView.tableFooterView = footerView
        
        listView.registerNib(UINib(nibName: "SectionHeaderWithButton", bundle: nil), forHeaderFooterViewReuseIdentifier: sectionHeaderWithButtonIdentifier)
        listView.registerNib(UINib(nibName: "SectionHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: sectionHeaderIdentifier)

        
        listView.registerNib(UINib(nibName: "ColorCell", bundle: nil), forCellReuseIdentifier: colorCellIdentifier)
        listView.registerNib(UINib(nibName: "PaintEstimationCell", bundle: nil), forCellReuseIdentifier: paintEstimationCellIdentifier)

        listView.delegate = self
        listView.dataSource = self
        
        createMyProjectDetail()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createMyProjectDetail(){
        
        var colorArray : [AnyObject] = []
        
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
        palette.values.append(color)
        
        color = Color()
        color.title = "Misty Grey"
        color.subTitle = "HDC-CL-01"
        color.value = UIColor.redColor()
        palette.values.append(color)

        color = Color()
        color.title = "Clay"
        color.subTitle = "HDC-CL-01"
        color.value = UIColor.redColor()
        palette.values.append(color)
        
        color = Color()
        color.title = "Golden Yellow"
        color.subTitle = "HDC-CL-01"
        color.value = UIColor.redColor()
        palette.values.append(color)

        colorArray.append(palette)
        
        myProject?.detail.append(["Colors" : colorArray])
        
        var paintEstimationArray : [PaintEstimation] = []
        
        var estimation = PaintEstimation()
        estimation.surfaceName = "Walls"
        estimation.quantity = 2
        estimation.weight =  1
        paintEstimationArray.append(estimation)
        
        estimation = PaintEstimation()
        estimation.surfaceName = "Doors"
        estimation.quantity = 2
        estimation.weight =  1
        paintEstimationArray.append(estimation)
        
        estimation = PaintEstimation()
        estimation.surfaceName = "Tim"
        estimation.quantity = 2
        estimation.weight =  1
        paintEstimationArray.append(estimation)
        
        estimation = PaintEstimation()
        estimation.surfaceName = "Celing"
        estimation.quantity = 2
        estimation.weight =  1
        paintEstimationArray.append(estimation)
        
        myProject?.detail.append(["PaintEstimation" : paintEstimationArray])
    }
    
}

// MARK:

extension ProjectDetailViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return (myProject?.detail.count)!
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let detailDict = (myProject?.detail[indexPath.section])! as! [String:[AnyObject]]
        
        if detailDict.keys.first == "Colors" {
        
            let colorCell = tableView.dequeueReusableCellWithIdentifier(colorCellIdentifier) as? ColorCell
            colorCell?.colorArray = detailDict["Colors"]!
            return colorCell!
            
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(paintEstimationCellIdentifier) as? PaintEstimationCell
        cell?.estimationArray = detailDict["PaintEstimation"]!
        
        return cell!
        
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionView : MyProjectDetailSectionHeader?
        
        let detailDict = (myProject?.detail[section])! as! [String:[AnyObject]]
        
        if section < ((myProject?.detail.count)! - 1){
            
            sectionView = tableView.dequeueReusableHeaderFooterViewWithIdentifier(sectionHeaderIdentifier) as? MyProjectDetailSectionHeader
            
        }else{
        
            sectionView = tableView.dequeueReusableHeaderFooterViewWithIdentifier(sectionHeaderWithButtonIdentifier) as? MyProjectDetailSectionHeader
            sectionView?.sectionLbl.text = detailDict.keys.first

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
