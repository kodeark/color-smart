//
//  ColorDetailViewController.swift
//  ColorSmart
//
//  Created by David on 14/06/16.
//  Copyright © 2016 Behr. All rights reserved.
//

import UIKit

class ColorDetailOverlayViewController: ColorDetailViewController {

    @IBOutlet weak var popView: UIView!
    
    @IBOutlet weak var popOverTopView: UIView!
    @IBOutlet weak var popOverBottomView: UIView!
    
    @IBOutlet weak var paletteView: UIView!
    @IBOutlet weak var colorInfoView: UIView!
    @IBOutlet weak var resizeBtn: UIButton!
    @IBOutlet weak var colorDetailView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    
    
    var colorViewed = false
    var popOverScreen = PopOverScreen.PARTIAL
    var recognizer : UITapGestureRecognizer!
    
    enum PopOverScreen{
    
        case FULL , PARTIAL
    }
    
    
    
    
    @IBAction func close(sender: AnyObject) {
        
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func resize(sender: AnyObject) {
        
        switch popOverScreen {
            
            case .FULL:
                popOverScreen = .PARTIAL
                break
            case .PARTIAL:
                popOverScreen = .FULL
                break
            default:
                break
            
        }
        
        updatePopOverLayout()
        
    }
    
    @IBAction func openPalette(sender: AnyObject) {
        
        let nibName = isiPad() ? "ColorPaletteViewController_iPad" : "ColorPaletteViewController_iPhone"
        let colorPalette = ColorPaletteViewController(nibName: nibName, bundle: nil)
        self.navigationController!.pushViewController(colorPalette, animated: true)

    }
    
    @IBAction func openSimilarColors(sender: AnyObject) {
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        popView.layer.cornerRadius = 5.0
        popView.clipsToBounds = true
        
        view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if colorViewed == false{
            
            var frame = self.popView.bounds
            frame.size.width = CGRectGetWidth(self.view.bounds)-20
            frame.size.height = self.view.bounds.size.height/3
            self.popView.bounds = frame
            
            frame = self.popOverTopView.bounds
            frame.size.height = CGRectGetHeight(self.popView.bounds)
            self.popOverTopView.frame = frame
            
            frame = self.colorInfoView.frame
            frame.size.height = CGRectGetHeight(self.popOverTopView.frame)
            self.colorInfoView.frame = frame
            
            self.popOverTopView.bringSubviewToFront(self.colorInfoView)
            self.popView.bringSubviewToFront(self.popOverTopView)
            
            recognizer = UITapGestureRecognizer(target: self, action: #selector(ColorDetailOverlayViewController.close(_:)))
            popView.addGestureRecognizer(recognizer)
            
            self.closeBtn.hidden = true
            
        }else{
            
            updatePartialPopOverLayout()
        }
        
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        self.view.backgroundColor = UIColor.redColor()
        
        if recognizer != nil{
            popView.removeGestureRecognizer(recognizer)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updatePopOverLayout(){
    
        self.resizeBtn.hidden = false

        UIView.animateWithDuration(0.7, delay: 0.0, options: .CurveEaseInOut, animations: {
            
            var frame = CGRectZero
            
            switch self.popOverScreen {
            
            case .FULL:
                frame = self.popView.bounds
                frame.size.width = CGRectGetWidth(self.view.bounds)
                frame.size.height = CGRectGetHeight(self.view.bounds)
                self.popView.bounds = frame
                
                frame = self.popOverTopView.frame
                frame.size.height = CGRectGetHeight(self.popView.frame) - CGRectGetHeight(self.popOverBottomView.frame)
                self.popOverTopView.frame = frame
                
                frame = self.colorInfoView.frame
                frame.size.height = CGRectGetHeight(self.popOverTopView.frame)
                self.colorInfoView.frame = frame
                
                self.popOverTopView.bringSubviewToFront(self.colorInfoView)
                
                let yMin = CGRectGetMinY(self.closeBtn.frame)
                
                frame = self.colorDetailView.frame
                frame.origin.y = yMin
                self.colorDetailView.frame = frame

                
                break
            case .PARTIAL:
                self.updatePartialPopOverLayout()
                break
            default:
                break
                
            }
            
        }, completion: { finished in
        
            
        })
        
    }
    
    func updatePartialPopOverLayout(){
    
        var frame = CGRectZero

        frame = self.popView.bounds
        frame.size.width = CGRectGetWidth(self.view.bounds)-20
        frame.size.height = self.view.bounds.size.height - 100
        self.popView.bounds = frame
        
        frame = self.popOverTopView.frame
        frame.size.height = CGRectGetHeight(self.popView.frame) - CGRectGetHeight(self.popOverBottomView.frame)
        self.popOverTopView.frame = frame
        
        frame = self.colorInfoView.frame
        frame.size.height = CGRectGetHeight(self.popOverTopView.bounds) - CGRectGetHeight(self.paletteView.bounds)
        self.colorInfoView.frame = frame
        
        self.resizeBtn.hidden = false
        
        let yMax = CGRectGetMaxY(self.resizeBtn.frame)
        let yMin = yMax - CGRectGetHeight(self.colorDetailView.bounds)
        
        frame = self.colorDetailView.frame
        frame.origin.y = yMin
        self.colorDetailView.frame = frame


    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
