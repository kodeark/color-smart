//
//  SearchListViewController.swift
//  ColorSmart
//
//  Created by David on 13/07/16.
//  Copyright © 2016 Behr. All rights reserved.
//

import UIKit

class SearchListViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .None
        tableView.sectionHeaderHeight = 20
        tableView.registerNib(UINib(nibName: "SearchListViewCell", bundle:nil), forCellReuseIdentifier: "SearchListViewCell")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let lbl = UILabel.init(frame: CGRectZero)
        lbl.font = UIFont(name: "OpenSans-Regular", size: 14)
        lbl.textColor = UIColor.rgb(101, green: 109, blue: 120)
        lbl.text = "  SEARCH RESULTS"
        
        return lbl
    }
    

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SearchListViewCell", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 90
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        let colorDetail = ColorDetailOverlayViewController(nibName: "ColorDetailOverlayViewController", bundle: nil)
        colorDetail.colorViewed = true
        let navCtrl = UINavigationController(rootViewController: colorDetail)
        navCtrl.navigationBarHidden = true
        
        navCtrl.view.frame = self.view.bounds
        navCtrl.modalPresentationStyle = .Custom
        
        self.presentViewController(navCtrl, animated: true, completion: nil)

    }
    
}
