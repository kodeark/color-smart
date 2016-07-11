//
//  ColorDetailViewController.swift
//  ColorSmart
//
//  Created by David on 23/06/16.
//  Copyright © 2016 Behr. All rights reserved.
//

import UIKit

class ColorDetailViewController: CenterViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    @IBAction func paintRoom(sender: AnyObject) {
        
        NSLog("tapped paint a room")
    }
    
    @IBAction func saveToProject(sender: AnyObject) {
        
    }
    
    @IBAction func share(sender: AnyObject) {
        
        
    }

}
