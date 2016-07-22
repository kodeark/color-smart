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

    var myProject : MyProject?
    var collapsedSections = NSMutableIndexSet.init()
    
    let colorCellIdentifier = "ColorInfoCell"
    let coordinatedPaletteCellIdentifier = "CordinatedPaletteCell"
    let paintEstimationCellIdentifier = "PaintEstimationCellIdentifier"

    let sectionHeaderIdentifier = "SectionHeader"
    let sectionFooterIdentifier = "SectionFooter"

    override func viewDidLoad() {
        super.viewDidLoad()

        addTopBarOnView(view)
        toolBar.setBackBtnTitle("My Projects")
        
        let topContainerConstraint : NSArray = NSLayoutConstraint.constraintsWithVisualFormat("V:[toolBar][containerView]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["containerView": containerView, "toolBar" : toolBar])
        view.addConstraints(topContainerConstraint as! [NSLayoutConstraint])
        
        listView.registerNib(UINib(nibName: "MyProjectDetailSectionHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: sectionHeaderIdentifier)
        listView.registerNib(UINib(nibName: "MyProjectDetailSectionFooter", bundle: nil), forHeaderFooterViewReuseIdentifier: sectionFooterIdentifier)

        listView.registerNib(UINib(nibName: "ColorInfoCell", bundle: nil), forCellReuseIdentifier: colorCellIdentifier)
        listView.registerNib(UINib(nibName: "CordinatedPaletteCell", bundle: nil), forCellReuseIdentifier: coordinatedPaletteCellIdentifier)
        listView.registerNib(UINib(nibName: "PaintEstimationSubCell", bundle: nil), forCellReuseIdentifier: paintEstimationCellIdentifier)
        
        listView.delegate = self
        listView.dataSource = self
        
        createMyProjectDetail()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
    
}

// MARK:

extension ProjectDetailViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return (myProject?.detail.count)!
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let detailDict = (myProject?.detail[section])! as! [String:[AnyObject]]
        let key = detailDict.keys.first
        let array = detailDict[key!]
        return array!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let detailDict = (myProject?.detail[indexPath.section])! as! [String:[AnyObject]]
        
        if detailDict.keys.first == "Colors" {
        
            let colorArray = detailDict["Colors"]!
            let detail = (colorArray[indexPath.row])
            
            if detail is Color{
                
                let colorDetail = detail as? Color
                
                let colorCell = tableView.dequeueReusableCellWithIdentifier(colorCellIdentifier) as? ColorInfoCell
                colorCell?.colorView.backgroundColor = colorDetail!.value
                colorCell?.mainLbl.text = colorDetail!.title
                colorCell?.subLbl.text = colorDetail!.subTitle
                
                return colorCell!
                
            }
            
            let paletteDetail = detail as? CordinatedPalette
            
            let cordinatedPaletteCell = tableView.dequeueReusableCellWithIdentifier(coordinatedPaletteCellIdentifier) as? CordinatedPaletteCell
            cordinatedPaletteCell?.cordinatedPalette = paletteDetail

            return cordinatedPaletteCell!
        }
        
        
        let estimationArray = detailDict["PaintEstimation"]!
        
        let paintDetail = (estimationArray[indexPath.row]) as! PaintEstimation
        
        let cell = tableView.dequeueReusableCellWithIdentifier(paintEstimationCellIdentifier) as? PaintEstimationSubCell
        cell!.surfaceName.text = paintDetail.surfaceName
        cell?.weight.text = "\(paintDetail.weight) gal"
        cell?.quantity.text = "\(paintDetail.quantity) qt"
        
        cell?.contentView.backgroundColor = (indexPath.row%2 == 0) ? UIColor.init(hexString: "#aab2bd") : UIColor.init(hexString: "#ccd0db")

        
        return cell!
        
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionView = tableView.dequeueReusableHeaderFooterViewWithIdentifier(sectionHeaderIdentifier) as? MyProjectDetailSectionHeader
        
        if section == ((myProject?.detail.count)! - 1){
            
            sectionView?.expandCollapseView.hidden = true
            sectionView?.sectionLbl.text = "PAINT NEEDED"
            sectionView?.sectionLbl.textColor = UIColor.whiteColor()
            sectionView?.contentView.backgroundColor = UIColor.init(hexString: "#656D78")
            
            return sectionView!

        }
        
        sectionView?.expandCollapseView.hidden = false
        
        let detailDict = (myProject?.detail[section])! as! [String:[AnyObject]]
        if detailDict.keys.first == "Colors" {
            
            sectionView?.sectionLbl.text = "COLORS"
        }
        return sectionView!
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let sectionFooter = tableView.dequeueReusableHeaderFooterViewWithIdentifier(sectionFooterIdentifier) as? MyProjectDetailSectionFooter
        
        let detailDict = (myProject?.detail[section])! as! [String:[AnyObject]]
        
        sectionFooter?.contentView.backgroundColor = UIColor.init(hexString: "#656D78")

        if detailDict.keys.first == "Colors"{
            sectionFooter!.footerBtn.titleLabel!.text = "ADD COLOR"
            sectionFooter?.separator.hidden = false
            
        }else{
        
            sectionFooter?.contentView.backgroundColor = UIColor.init(hexString: "#37BD9C")
            sectionFooter!.footerBtn.titleLabel!.text = "RE-ESIMATE THE PAINT YOU NEED"
            sectionFooter?.separator.hidden = true
    
        }
        
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
        
        if section == ((myProject?.detail.count)! - 1){
        
            return 29
        }
        
        return 46
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        
        let detailDict = (myProject?.detail[indexPath.section])! as! [String:[AnyObject]]
        
        if detailDict.keys.first == "Colors" {
         
            let colorArray = detailDict["Colors"]!
            let detail = (colorArray[indexPath.row])
            
            if detail is Color{
                
                return 97
            }else{
            
                return 286
            }
        }
        
        return 60
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 74
    }
    
}
