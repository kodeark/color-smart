//
//  ColorCell.swift
//  ColorSmart
//
//  Created by David on 21/07/16.
//  Copyright © 2016 Behr. All rights reserved.
//

import UIKit

class ColorCell: UITableViewCell {

    @IBOutlet weak var listView: UITableView!
    
    let colorCellIdentifier = "ColorInfoCell"
    let coordinatedPaletteCellIdentifier = "CordinatedPaletteCell"

    var colorArray : [AnyObject] = [] {
    
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

extension ColorCell: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return colorArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let detail = (colorArray[indexPath.section])
        
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
        cordinatedPaletteCell?.cordinatedPalette = (paletteDetail?.values)!
            
        return cordinatedPaletteCell!
        
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
       
        let sectionFooter = SectionFooter()
        sectionFooter.addNewDetailBtn.titleLabel!.text = "ADD COLOR"
       
        return sectionFooter
    }
    
}
