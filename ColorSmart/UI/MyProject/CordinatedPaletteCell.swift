//
//  MyProjectDetailCordinatedPaletteCell.swift
//  ColorSmart
//
//  Created by David on 21/07/16.
//  Copyright © 2016 Behr. All rights reserved.
//

import UIKit

class CordinatedPaletteCell: MyProjectDetailBaseCell {

    @IBOutlet weak var paletteView: UIView!
    
    @IBOutlet weak var colorListView: UITableView!
    
    let cellIdentifier = "CellId"
    var cordinatedPalette  : CordinatedPalette?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        colorListView.registerNib(UINib(nibName: "ColorInfoCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)

    }

    @IBAction func moveToTrash(sender: AnyObject) {
        
        delegate.moveToTrash(self)
    }
}

extension CordinatedPaletteCell: UITableViewDataSource{

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (cordinatedPalette?.values.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? ColorInfoCell
        if cell != nil{
            
           let colorInfo = cordinatedPalette!.values[indexPath.row]
           cell!.trashBtnWidthConstraint.constant = 0
           cell!.mainLbl.font = UIFont(name: "OpenSans-Bold", size: 12)
           cell!.subLbl.font = UIFont(name: "OpenSans-Bold", size: 10)
           cell!.colorView.backgroundColor = colorInfo.value
           cell!.mainLbl.text = colorInfo.title
           cell!.subLbl.text = colorInfo.subTitle
        }
        return cell!
        
    }

}

extension CordinatedPaletteCell: UITableViewDelegate{

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return CGRectGetHeight(tableView.bounds)/CGFloat(cordinatedPalette!.values.count)
    }
}