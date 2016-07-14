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
    
    let cellId = "InspirationCell"
    let inspirationList = ["KITCHEN (8)","BATHROOM (7)","LIVING (5)", "KITCHEN (8)","BATHROOM (7)","LIVING (5)"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addTopBarOnView(view)
        toolBar.setBackBtnTitle("INSPIRATION")
        
        let topContainerConstraint = NSLayoutConstraint.init(item: containerView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: toolBar, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0)
        view.addConstraint(topContainerConstraint)
        
        setupShowCaseView()//TODO:Need to implement condition based addition of showcase or scrapbook.
        
        collectionView.registerNib(UINib(nibName: "InspirationCell", bundle:nil), forCellWithReuseIdentifier: cellId)
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
        
        let topContainerConstraint = NSLayoutConstraint.init(item: contentView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: showCaseView, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0)
        contentView.addConstraint(topContainerConstraint)
        
        let bottomContainerConstraint = NSLayoutConstraint.init(item: contentView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: showCaseView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0)
        contentView.addConstraint(bottomContainerConstraint)
        
        let leadingContainerConstraint = NSLayoutConstraint.init(item: contentView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: showCaseView, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0)
        contentView.addConstraint(leadingContainerConstraint)
        
        let trailingContainerConstraint = NSLayoutConstraint.init(item: contentView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: showCaseView, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 0)
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
        menuBar.updateHeaderTitles(inspirationList)
    }
    
    
    @IBAction func showCaseTypeChanged(sender: AnyObject){
    
    
    }
}

extension InspirationViewController : UICollectionViewDataSource{

    
     func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return inspirationList.count
    }
    
     func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! InspirationCell
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(collectionView.frame.width, collectionView.frame.height)
    }

}

extension InspirationViewController : UIScrollViewDelegate{
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
  //      menuBar.horizontalBarLeftConstraint?.constant = scrollView.contentOffset.x / CGFloat(inspirationList.count)
    }
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let index = targetContentOffset.memory.x / view.frame.width
        
        let indexPath = NSIndexPath(forItem: Int(index), inSection: 0)
        menuBar.collectionView.selectItemAtIndexPath(indexPath, animated: true, scrollPosition: .None)
        
    }
    
}

extension InspirationViewController : MenuBarDelegate {

    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = NSIndexPath(forItem: menuIndex, inSection: 0)
        collectionView?.scrollToItemAtIndexPath(indexPath, atScrollPosition: .None, animated: true)
    }
}

