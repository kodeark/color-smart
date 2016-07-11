//
//  ColorMatchPickerViewController.swift
//  ColorSmart
//
//  Created by David on 5/07/16.
//  Copyright © 2016 Behr. All rights reserved.
//

import UIKit

class ColorMatchPickerViewController: CenterViewController {

    var pickerImage : UIImage?
    
    @IBOutlet weak var pickerImageView: UIImageView!
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var colorPanelView: UIView!
    
    @IBOutlet weak var imageContainerView: UIView!
        
    var containerTopConstraint : NSLayoutConstraint! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        pickerImageView.image = pickerImage
        
        self.addTopBarOnView(view)
        toolBar.setBackBtnTitle("COLOR MATCH")
        
        let toolBarItems = ColorPickerToolBarItems.instanceFromNib()
        toolBarItems.delegate = self        
        toolBar.addRightBarButtonItems(toolBarItems)
        
        
        
//        let colorPanel = ColorPanel.instanceFromNib()
//        colorPanel.delegate = self
//        colorPanel.autoresizingMask = .FlexibleWidth
//        colorPanelView.addSubview(colorPanel)
        
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
        
        if containerTopConstraint == nil {
            
            containerTopConstraint = NSLayoutConstraint.init(item: containerView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: toolBar, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0)
            
            view.addConstraint(containerTopConstraint)
        }
        
    }
        
    @IBAction func saveSelectedColor(sender: AnyObject) {
    }
    
    @IBAction func paintRoom(sender: AnyObject) {
    }
    @IBAction func save(sender: AnyObject) {
    }
    
    @IBAction func clearAll(sender: AnyObject) {
    }
    
    func resizeImage(){
    
    }
    
    func replaceImage(){
    
    
    }
}


extension ColorMatchPickerViewController:ColorPanelDelegate{



}

extension ColorMatchPickerViewController:ColorPickerToolBarItemsDelegate{
    
    
    
}
