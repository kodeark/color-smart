//
//  InspirationViewController.swift
//  ColorSmart
//
//  Created by David on 14/07/16.
//  Copyright © 2016 Behr. All rights reserved.
//

import UIKit

class InspirationViewController: CenterViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet var showCaseView: UIView!
    @IBOutlet weak var showCaseTypeSegmentedCtrl: ADVSegmentedControl!
    @IBOutlet weak var showCaseSubTypeSegmentedCtrl: ADVSegmentedControl!
    @IBOutlet weak var menuBar: MenuBar!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var collectionViewTopConstraint: NSLayoutConstraint!
    
    let cellId = "InspirationPageCell"
    let categoryList = ["KITCHEN (8)","BATHROOM (7)","LIVING (5)", "KITCHEN (8)","BATHROOM (7)","LIVING (5)"]
    var itemsList : NSMutableArray = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addTopBarOnView(view)
        toolBar.setBackBtnTitle("INSPIRATION")
        
        let topContainerConstraint : NSArray = NSLayoutConstraint.constraintsWithVisualFormat("V:[toolBar][containerView]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["containerView": containerView, "toolBar" : toolBar])
        view.addConstraints(topContainerConstraint as! [NSLayoutConstraint])
        
        setupShowCaseView()//TODO:Need to implement condition based addition of showcase or scrapbook.
        
        collectionView.registerClass(InspirationPageCell.self, forCellWithReuseIdentifier: cellId)
        let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        flowLayout?.minimumLineSpacing = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setupShowCaseView(){
    
        showCaseView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(showCaseView)
        
        let topContainerConstraint = NSLayoutConstraint.init(item: showCaseView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0)
        contentView.addConstraint(topContainerConstraint)
        
        let bottomContainerConstraint = NSLayoutConstraint.init(item: showCaseView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0)
        contentView.addConstraint(bottomContainerConstraint)
        
        let leadingContainerConstraint = NSLayoutConstraint.init(item: showCaseView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0)
        contentView.addConstraint(leadingContainerConstraint)
        
        let trailingContainerConstraint = NSLayoutConstraint.init(item: showCaseView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 0)
        contentView.addConstraint(trailingContainerConstraint)
        
        let font = UIFont(name: "OpenSans-Semibold", size: 14.0)
        let selectedIndex = 0
        
        showCaseTypeSegmentedCtrl.items = ["INTERIOR SHOWCASE", "EXTERIOR SHOWCASE"]
        showCaseTypeSegmentedCtrl.font = font
        showCaseTypeSegmentedCtrl.selectedIndex = selectedIndex
        showCaseTypeSegmentedCtrl.addTarget(self, action: #selector(InspirationViewController.showCaseTypeChanged(_:)), forControlEvents: .ValueChanged)
        
        showCaseSubTypeSegmentedCtrl.items = ["ROOM", "STYLE", "COLOR"]
        showCaseSubTypeSegmentedCtrl.font = font
        showCaseSubTypeSegmentedCtrl.selectedIndex = selectedIndex
        showCaseSubTypeSegmentedCtrl.addTarget(self, action: #selector(InspirationViewController.showCaseTypeChanged(_:)), forControlEvents: .ValueChanged)
        
        menuBar.delegate = self
        menuBar.updateHeaderTitles(categoryList)
        
        loadCollectionView()
        
    }
    
    func loadCollectionView(){
    
        itemsList.removeAllObjects()
        
        //Need to change with actual data
        var item = InspirationItem()
        item.title = "Traditional Bathroom"
        itemsList.addObject(item)
        
        item = InspirationItem()
        item.title = "Casual Bathroom"
        itemsList.addObject(item)

        item = InspirationItem()
        item.title = "Spa-inspired Bathroom"
        itemsList.addObject(item)

        collectionView.reloadData()
    }
    
    
    @IBAction func showCaseTypeChanged(sender: AnyObject){
    
        self.collectionViewTopConstraint.constant = CGRectGetHeight(self.showCaseView.frame)
        self.showCaseView.layoutIfNeeded()
        
        self.collectionViewTopConstraint.constant = 0.0
        UIView.animateWithDuration(0.3, animations: {
        
            self.showCaseView.layoutIfNeeded()
        })
        
       loadCollectionView()
    }
}

extension InspirationViewController : UICollectionViewDataSource{

    
     func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList.count
    }
    
     func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! InspirationPageCell
        cell.updateInspiration(itemsList)

        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(collectionView.frame.width, collectionView.frame.height)
    }

}

extension InspirationViewController : UIScrollViewDelegate{
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        menuBar.horizontalBarLeftConstraint?.constant = scrollView.contentOffset.x / CGFloat(categoryList.count)
        menuBar.layoutIfNeeded()
    }
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let index = targetContentOffset.memory.x / view.frame.width
        
        let indexPath = NSIndexPath(forItem: Int(index), inSection: 0)
       // menuBar.collectionView.selectItemAtIndexPath(indexPath, animated: true, scrollPosition: .None)
        menuBar.collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.None, animated: true)
        
    }
    
}

extension InspirationViewController : MenuBarDelegate {

    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = NSIndexPath(forItem: menuIndex, inSection: 0)
        collectionView?.scrollToItemAtIndexPath(indexPath, atScrollPosition: .None, animated: true)
    }
}

