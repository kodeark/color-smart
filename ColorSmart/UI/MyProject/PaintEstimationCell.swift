//
//  PaintEstimationCell.swift
//  ColorSmart
//
//  Created by David on 21/07/16.
//  Copyright © 2016 Behr. All rights reserved.
//

import UIKit

class PaintEstimationCell: UITableViewCell {

    @IBOutlet weak var listView: UITableView!
    
    let cellId = "cellId"

    var estimationArray : [AnyObject] = [] {
        
        didSet{
            
            listView.reloadData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

// MARK:

extension PaintEstimationCell: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return estimationArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let list = (estimationArray[indexPath.section]) as! [AnyObject]
        let detail = list[indexPath.row]
        
        let paintDetail = detail as? PaintEstimation
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? PaintEstimationSubCell
        cell!.surfaceName.text = paintDetail?.surfaceName
        cell?.weight.text = "\(paintDetail?.weight) gal"
        cell?.quantity.text = "\(paintDetail?.quantity) qt"

        return cell!
        
    }
       
}
