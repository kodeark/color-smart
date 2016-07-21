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
    
    @IBOutlet weak var colorListView: UIView!
    
    let cellIdentifier = "CellId"
    var cordinatedPalette  : [Color] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
        
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? ColorInfoCell
        if cell != nil{
            
           cell?.colorView.backgroundColor = UIColor.redColor()
           cell?.mainLbl.text = "Timeless Red"
           cell?.subLbl.text = "HDC-CL-01"
        }
        return cell!
        
    }


}