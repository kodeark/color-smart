//
//  ColorPanel.swift
//  ColorSmart
//
//  Created by David on 7/07/16.
//  Copyright © 2016 Behr. All rights reserved.
//

import UIKit

@objc
protocol ColorPanelDelegate {
    
    optional func updateColorInfo()
}

class ColorPanel: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var delegate : ColorPanelDelegate?
    
    @IBOutlet weak var colorTile: UIView!
    @IBOutlet weak var infoLbl: UILabel!
    
    class func instanceFromNib() -> ColorPanel {
        return UINib(nibName: "ColorPanel", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! ColorPanel
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
       // updatePanel(nil)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func getHeight() -> CGFloat{
    
        return CGRectGetMaxY(infoLbl.frame)
    
    }
    
    /*
    func updatePanel(color : UIColor) {
        
        if color != nil{
            
            let xPosition = 0.0
            let count = self.subviews.count
            for item in self.subviews {
                
                if item.isKindOfClass(ColorPanelItem){
                
                    xPosition = xPosition + CGRectGetMaxX(item)
                }
            }
            
            addColor(count, color:color, position: xPosition)
            
            colorTile.hidden = false
            infoLbl.hidden = true

            var frame = infoLbl.frame
            frame.origin.y = CGRectGetMaxY(colorTile.frame)
            infoLbl.frame = frame
            
        }else{
        
            colorTile.hidden = true
            infoLbl.hidden = false
            
            var frame = infoLbl.frame
            frame.origin.y = 40.0
            infoLbl.frame = frame
        }
    }*/
    
    func addColor(index :Int, color :UIColor, position:CGFloat){
    
        let colorPanelItem = ColorPanelItem.instanceFromNib()
        var frame = colorPanelItem.frame
        frame.origin.x = position
        colorPanelItem.frame = frame
        
    }
    
    func deleteColor(){
        
        
        
    }

}
