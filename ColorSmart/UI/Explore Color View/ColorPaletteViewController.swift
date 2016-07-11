//
//  ColorPaletteViewController.swift
//  ColorSmart
//
//  Created by David on 23/06/16.
//  Copyright © 2016 Behr. All rights reserved.
//

import UIKit

class ColorPaletteViewController: ColorDetailViewController {
    
    @IBOutlet weak var toolBarView: UIView!
    
    @IBOutlet weak var colorInfoView: UIView!
    
    @IBOutlet var paletteView: UIView!
    
    @IBOutlet var tabSelectionBgView: UIImageView!
    @IBOutlet weak var mainColorBtn: UIButton!
    
    @IBOutlet weak var accentColorBtn: UIButton!
    
    @IBAction func tabSelected(sender: AnyObject) {
        
        switch sender.tag {
        case 200:
           tabSelectionBgView.image = UIImage(named: "Tab Selection Left")
            break
        case 201:
            tabSelectionBgView.image = UIImage(named: "Tab Selection Right")
            break
        default:
            break
        }
        
        self.view.bringSubviewToFront(mainColorBtn)
        self.view.bringSubviewToFront(accentColorBtn)

        
    }
    
    @IBAction func categorySelected(sender: AnyObject) {
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        paletteView.backgroundColor = UIColor.brownColor()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
                
        self.addTopBarOnView(view)
        
        toolBar.setBackBtnTitle("PALETTES")
    
        var frame = paletteView.frame
        frame.origin.y = CGRectGetMaxY(toolBar.frame)
        frame.size.height = CGRectGetHeight(paletteView.bounds) + CGRectGetHeight(toolBar.bounds)
        paletteView.frame = frame
    }
    
}
