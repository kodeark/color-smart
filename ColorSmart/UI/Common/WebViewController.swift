//
//  WebViewController.swift
//  ColorSmart
//
//  Created by David on 27/07/16.
//  Copyright © 2016 Behr. All rights reserved.
//

import UIKit
import MBProgressHUD

class WebViewController: CenterViewController {

    @IBOutlet weak var webView: UIWebView!
    
    var request : NSMutableURLRequest?
    var pageTitle : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addTopBarOnView(view)
        toolBar.setBackBtnTitle(pageTitle!)
        
        let topContainerConstraint : NSArray = NSLayoutConstraint.constraintsWithVisualFormat("V:[toolBar][containerView]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["containerView": webView, "toolBar" : toolBar])
        view.addConstraints(topContainerConstraint as! [NSLayoutConstraint])

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
    
    
    init(aRequest: NSMutableURLRequest, pageTitle: String){
    
        super.init(nibName:nil, bundle:nil)
        request = aRequest
        self.pageTitle = pageTitle
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Webview delegate
    
    func webViewDidStartLoad(webView: UIWebView){
    
        MBProgressHUD.showHUDAddedTo(view, animated: true)
    }
    
    func webViewDidFinishLoad(webView: UIWebView){
        
        MBProgressHUD.hideHUDForView(view, animated: true)

    }

    func webView(webView: UIWebView, didFailLoadWithError error: NSError?){
        
        MBProgressHUD.hideHUDForView(view, animated: true)
    }


}
