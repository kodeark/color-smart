//
//  TreeViewController.swift
//  ColorSmart
//
//  Created by David on 25/05/16.
//  Copyright © 2016 Behr. All rights reserved.
//

import Foundation

class TreeViewController: UIViewController, RATreeViewDelegate, RATreeViewDataSource {
    
    var treeView : RATreeView!
    var data : [DataObject]
    
    convenience init() {
        self.init(nibName : nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        data = TreeViewController.commonInit()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        data = TreeViewController.commonInit()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.clearColor()
        
        title = ""
        setupTreeView()
    }
    
    func setupTreeView() -> Void {
        treeView = RATreeView(frame: view.bounds)
        treeView.registerNib(UINib.init(nibName: "TreeTableViewCell", bundle: nil), forCellReuseIdentifier: "TreeTableViewCell")
        treeView.autoresizingMask = UIViewAutoresizing(rawValue:UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        treeView.delegate = self;
        treeView.dataSource = self;
        treeView.treeFooterView = UIView()
        treeView.setEditing(false, animated: false)
        treeView.separatorStyle = RATreeViewCellSeparatorStyleNone
        view.addSubview(treeView)
    }
    
    //MARK: RATreeView data source
    
    func treeView(treeView: RATreeView, numberOfChildrenOfItem item: AnyObject?) -> Int {
        if let item = item as? DataObject {
            return item.children.count
        } else {
            return self.data.count
        }
    }
    
    func treeView(treeView: RATreeView, child index: Int, ofItem item: AnyObject?) -> AnyObject {
        if let item = item as? DataObject {
            return item.children[index]
        } else {
            return data[index] as AnyObject
        }
    }
    
    func treeView(treeView: RATreeView, cellForItem item: AnyObject?) -> UITableViewCell {
        let cell = treeView.dequeueReusableCellWithIdentifier("TreeTableViewCell") as! TreeTableViewCell
        let item = item as! DataObject
        
        let level = treeView.levelForCellForItem(item)

        cell.selectionStyle = .None
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
       
        
        let dropDownButtonHidden = (item.children.count > 0) ? false:true
        cell.setup(withTitle: item.name,level: level, dropDownButtonHidden: dropDownButtonHidden)
        return cell
    }
    
    func treeView(treeView: RATreeView, editingStyleForRowForItem item: AnyObject) -> UITableViewCellEditingStyle {
        
        
        return UITableViewCellEditingStyle.None
    }
    
    func treeView(treeView: RATreeView, didSelectRowForItem item: AnyObject) {
        
       // let webViewCtrl = WebViewController.init(aRequest: NSMutableURLRequest.init(URL: NSURL.init(string: "www.google.com")), pageTitle: "Sheen Guide"))
        
    }
    
}


private extension TreeViewController {
    
    static func commonInit() -> [DataObject] {
        
        let home = DataObject(name: "Home")
        
        let colors = DataObject(name: "Colors")
        let inspiration = DataObject(name: "Inspiration")
        let projects = DataObject(name: "Projects")
        
        let colorMatch = DataObject(name: "Color Match")
        let paintRoom = DataObject(name: "Paint a room")
        
        let sampleHistory = DataObject(name: "Sample history")
        let storeLocator = DataObject(name: "Store Locator")
        let paintCalculator = DataObject(name: "Paint calculator")
        let orderSamples = DataObject(name: "Order samples")
        let askAnExpert = DataObject(name: "Ask an expert")
        let productGuide = DataObject(name: "Product guide")
        let sheenGuide = DataObject(name: "Sheen guide")
        let barcodeScanner = DataObject(name: "Barcode scanner")

        let tools = DataObject(name: "Tools", children: [sampleHistory, storeLocator, paintCalculator, orderSamples, askAnExpert, productGuide,
                                                            sheenGuide, sheenGuide, barcodeScanner])

        
        return [home, colors, inspiration, projects, colorMatch, paintRoom, tools]
    }
    
}
