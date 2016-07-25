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
    @IBOutlet weak var projectTitleLbl: UILabel!

    var myProject : MyProject?
    var collapsedSections = NSMutableIndexSet.init()
    
    let colorCellIdentifier = "ColorInfoCell"
    let coordinatedPaletteCellIdentifier = "CordinatedPaletteCell"
    let paintEstimationCellIdentifier = "PaintEstimationCellIdentifier"

    let sectionHeaderIdentifier = "SectionHeader"
    let sectionFooterIdentifier = "SectionFooter"

    // MARK:
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addTopBarOnView(view)
        toolBar.setBackBtnTitle("My Projects")
        
        let topContainerConstraint : NSArray = NSLayoutConstraint.constraintsWithVisualFormat("V:[toolBar][containerView]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["containerView": containerView, "toolBar" : toolBar])
        view.addConstraints(topContainerConstraint as! [NSLayoutConstraint])
        
        // Fix for extra space appearing above tableview.
        let tableViewHeaderView = UIView.init(frame: CGRectMake(0.0, 0.0,listView.bounds.size.width, CGFloat.min));
        listView.tableHeaderView = tableViewHeaderView;
        
        listView.registerNib(UINib(nibName: "MyProjectDetailSectionHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: sectionHeaderIdentifier)
       
        listView.registerNib(UINib(nibName: "MyProjectDetailSectionFooter", bundle: nil), forCellReuseIdentifier: sectionFooterIdentifier)
        listView.registerNib(UINib(nibName: "ColorInfoCell", bundle: nil), forCellReuseIdentifier: colorCellIdentifier)
        listView.registerNib(UINib(nibName: "CordinatedPaletteCell", bundle: nil), forCellReuseIdentifier: coordinatedPaletteCellIdentifier)
        listView.registerNib(UINib(nibName: "PaintEstimationSubCell", bundle: nil), forCellReuseIdentifier: paintEstimationCellIdentifier)
        
        
        listView.delegate = self
        listView.dataSource = self
        
        projectTitleLbl.text = myProject?.name
        
        createMyProjectDetail()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:
    func createMyProjectDetail(){
        
        myProject?.detail.removeAll()
        
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
    
    func toggleSectionHeader(sender : UIButton){
    
        let section = sender.tag
        if collapsedSections.containsIndex(section){
            
            collapsedSections.removeIndex(section)
            
        }else{
            
            collapsedSections.addIndex(section)
        }
        
        listView.beginUpdates()
        listView.reloadSections(NSIndexSet.init(index: section), withRowAnimation: .Fade)
        listView.endUpdates()
    }
    
    func addColor(sender : UIButton){
    
    
    }
    
    func estimatePaint(sender : UIButton){
        
        
    }
    
    func deleteItem(indexPath : NSIndexPath){
    
        listView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
}

// MARK:

extension ProjectDetailViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return (myProject?.detail.count)!
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (myProject?.detail.count >  0) && !collapsedSections.containsIndex(section){
            
            let detailDict = (myProject?.detail[section])! as! [String:[AnyObject]]
            let key = detailDict.keys.first
            let array = detailDict[key!]
            return array!.count + 1 //Extra one row is added to include Add button under each section.
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let detailDict = (myProject?.detail[indexPath.section])! as! [String:[AnyObject]]
        
        let key = detailDict.keys.first
        let detailList = detailDict[key!]

        if indexPath.row < detailList!.count{
        
            if key == "Colors" {
                
                let detail = (detailList![indexPath.row])
                
                if detail is Color{
                    
                    let colorDetail = detail as! Color
                    
                    let colorCell = tableView.dequeueReusableCellWithIdentifier(colorCellIdentifier) as! ColorInfoCell
                    colorCell.indexPath = NSIndexPath(forRow: indexPath.row, inSection: indexPath.section)
                    colorCell.colorView.backgroundColor = colorDetail.value
                    colorCell.mainLbl.text = colorDetail.title
                    colorCell.subLbl.text = colorDetail.subTitle
                    
                    return colorCell
                    
                }
                
                let paletteDetail = detail as? CordinatedPalette
                
                let cordinatedPaletteCell = tableView.dequeueReusableCellWithIdentifier(coordinatedPaletteCellIdentifier) as! CordinatedPaletteCell
                cordinatedPaletteCell.indexPath = NSIndexPath(forRow: indexPath.row, inSection: indexPath.section)
                cordinatedPaletteCell.cordinatedPalette = paletteDetail
                
                return cordinatedPaletteCell
            }
            
            
            let estimationArray = detailDict["PaintEstimation"]!
            
            let paintDetail = (estimationArray[indexPath.row]) as! PaintEstimation
            
            let cell = tableView.dequeueReusableCellWithIdentifier(paintEstimationCellIdentifier) as! PaintEstimationSubCell
            cell.surfaceName.text = paintDetail.surfaceName
            cell.weight.text = "\(paintDetail.weight) gal"
            cell.quantity.text = "\(paintDetail.quantity) qt"
            
            cell.contentView.backgroundColor = (indexPath.row%2 == 0) ? UIColor.rgb(170, green: 178, blue: 189) :  UIColor.rgb(204, green: 208, blue: 219)
            
            return cell
            
        }
        
        return  self.tableView(tableView, cellForFooterInSection: indexPath.section)!
        
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionView = tableView.dequeueReusableHeaderFooterViewWithIdentifier(sectionHeaderIdentifier) as! MyProjectDetailSectionHeader
        
        if (section + 1) == (myProject?.detail.count)!{
            
            sectionView.sectionLbl.textColor = UIColor.whiteColor()
            sectionView.contentView.backgroundColor = UIColor.rgb(101, green: 109, blue: 120)
            sectionView.expandCollapseView.hidden = true
            sectionView.sectionLbl.text = "PAINT NEEDED"
            
            return sectionView

        }
        
        sectionView.expandCollapseView.hidden = false
        sectionView.sectionLbl.textColor = UIColor.rgb(101, green: 109, blue: 120)
        sectionView.contentView.backgroundColor = UIColor.whiteColor()
        sectionView.toggleBtn.addTarget(self, action: #selector(ProjectDetailViewController.toggleSectionHeader(_:)), forControlEvents: .TouchUpInside)
        sectionView.expandCollapseView.image = UIImage(named: (self.collapsedSections.containsIndex(section) ? "collapse":"expand"))
        sectionView.tag = section
        
        let detailDict = (myProject?.detail[section])! as! [String:[AnyObject]]
        if detailDict.keys.first == "Colors" {
            sectionView.sectionLbl.text = "COLORS"
        }
        return sectionView
    }
    
    func tableView(tableView: UITableView, cellForFooterInSection section: Int) -> MyProjectDetailSectionFooter? {
        
        let sectionFooter = tableView.dequeueReusableCellWithIdentifier(sectionFooterIdentifier) as! MyProjectDetailSectionFooter
        
        let detailDict = (myProject?.detail[section])! as! [String:[AnyObject]]
        
        sectionFooter.footerBtn.backgroundColor = UIColor.rgb(101, green: 109, blue: 120)
        
        if detailDict.keys.first == "Colors"{
            sectionFooter.footerBtn.setTitle("ADD COLOR", forState: .Normal)
            sectionFooter.footerBtn.addTarget(self, action: #selector(ProjectDetailViewController.addColor(_:)), forControlEvents: .TouchUpInside)
            sectionFooter.separator.hidden = false
            
            return sectionFooter
            
        }
        
        sectionFooter.footerBtn.backgroundColor = UIColor.rgb(55, green: 189, blue: 156)
        sectionFooter.footerBtn.setTitle("RE-ESIMATE THE PAINT YOU NEED", forState: .Normal)
        sectionFooter.separator.hidden = true
        sectionFooter.footerBtn.addTarget(self, action: #selector(ProjectDetailViewController.estimatePaint(_:)), forControlEvents: .TouchUpInside)

        return sectionFooter
    }

}

// MARK:
extension ProjectDetailViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String?{
        
        return "DELETE"
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if (section + 1) == (myProject?.detail.count)!{
        
            return 29
        }
        
        return 46
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let detailDict = (myProject?.detail[indexPath.section])! as! [String:[AnyObject]]
        
        let key = detailDict.keys.first
        let detailList = detailDict[key!]
        
        if indexPath.row < detailList!.count{

            if key == "Colors" {
                
                let detail = (detailList![indexPath.row])
                
                if detail is Color{
                    
                    return 97
                }else{
                    
                    return 286
                }
            }
            return 60
        }
        return 74
    }
    
    
}
