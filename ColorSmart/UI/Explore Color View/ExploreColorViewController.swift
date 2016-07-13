//
//  ExploreColorViewController.swift
//  ColorSmart
//
//  Created by David on 1/06/16.
//  Copyright © 2016 Behr. All rights reserved.
//

import UIKit

class ExploreColorViewController: CenterViewController {

    @IBOutlet var topView: UIView!
    @IBOutlet var bottomView: UIView!
    
    @IBOutlet weak var colorCategoryBar: UIView!
    @IBOutlet weak var colorFamilyTab: UIView!
    @IBOutlet weak var colorSwatch: UIView!
    
    @IBOutlet var toolBarItems: UIView!
    @IBOutlet weak var topContainerView: UIView!
    
    var parallaxScrollView : TKParallaxScrollView?
    var collectionView : UICollectionView!
    var flowLayout : UICollectionViewLayout!
    var searchCtrl : SearchListViewController!
    
    var selectedSwatchItemIndex = 0
    var selectedContentItemIndex = -1
    
    let noOfColumns = 5
    let spacing = 10.0
    
    let transition = PopAnimator()
    
    let colorCategoryList : NSMutableArray = ["COLOR FAMILIES", "COLLECTIONS", "MARQUEE PAINT", "POPULAR"]
    
    let colorFamilyList : NSMutableArray = [UIColor.redColor(), UIColor.blueColor(), UIColor.greenColor(), UIColor.yellowColor(), UIColor.brownColor(), UIColor.magentaColor()]
    
    let colorSwatchList : NSMutableArray = [[UIColor.redColor(), UIColor.blueColor(), UIColor.greenColor(),UIColor.redColor(), UIColor.blueColor(), UIColor.greenColor(),UIColor.redColor(), UIColor.blueColor(), UIColor.greenColor(),UIColor.redColor(), UIColor.blueColor(), UIColor.greenColor(),UIColor.redColor(), UIColor.blueColor(), UIColor.greenColor(),UIColor.redColor(), UIColor.blueColor(), UIColor.greenColor(),UIColor.redColor(), UIColor.blueColor(), UIColor.greenColor(),UIColor.blueColor(), UIColor.greenColor(),UIColor.redColor(), UIColor.blueColor(), UIColor.greenColor()],
                                            [UIColor.redColor(), UIColor.blueColor(), UIColor.greenColor()],
                                            [UIColor.redColor(), UIColor.blueColor(), UIColor.greenColor()],
                                            [UIColor.redColor(), UIColor.blueColor(), UIColor.greenColor()],
                                            [UIColor.redColor(), UIColor.blueColor(), UIColor.greenColor()],
                                            [UIColor.blueColor(), UIColor.redColor(), UIColor.greenColor()],
                                            [UIColor.greenColor(), UIColor.blueColor(), UIColor.redColor()]]
    
    
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        addTopBarOnView(topView)
        toolBar.setBackBtnTitle("COLORS")
        
        toolBar.addRightBarButtonItems(toolBarItems)
        
        toolBar.showSearchBar()
        
        let topContainerConstraint = NSLayoutConstraint.init(item: topContainerView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: toolBar, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0)
        topView.addConstraint(topContainerConstraint)
        
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        if parallaxScrollView == nil {
            parallaxScrollView = createParallaxScrollView()
        }
        
        if parallaxScrollView?.superview == nil {
            
            self.view.addSubview(parallaxScrollView!);
            
            let colorSwatchView = ColorSwatchView.instanceFromNib()
            colorSwatchView.delegate = self
            colorSwatch.addSubview(colorSwatchView)
            var frame = colorSwatch.bounds
            colorSwatch.frame = frame
            colorSwatchView.updateScrollView(colorSwatchList)
            
            let colorFamilyView = ColorFamilyView.instanceFromNib()
            colorFamilyTab.addSubview(colorFamilyView)
            frame = colorFamilyTab.bounds
            colorFamilyView.frame = frame
            colorFamilyView.updateScrollView(colorFamilyList)
        }
        
        createColorCollectionView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: -
    
    func createParallaxScrollView() -> TKParallaxScrollView{
        
        let baseScrollView = UIScrollView.init(frame: self.view.bounds)
        
        var topViewFrame = topView.frame
        var bottomViewFrame = bottomView.frame
        
        topViewFrame.size.width = CGRectGetWidth(view.bounds)
        topViewFrame.size.height = CGRectGetHeight(topContainerView.bounds) + CGRectGetMaxY(toolBar.frame)

        bottomViewFrame.size.width = CGRectGetWidth(view.bounds)
        bottomViewFrame.size.height = CGFloat(getColorCollectionViewHeight())

        topView.frame = topViewFrame
        bottomView.frame = bottomViewFrame
        
        baseScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(topView.frame) + CGRectGetHeight(bottomView.frame) + 64)
        
        parallaxScrollView = TKParallaxScrollView.init(frame: view.frame, withBaseScrollView: baseScrollView, withHeaderView: topView, withMidView: bottomView, isShrinkHeaderView: false, isShrinkMidView: false)
        parallaxScrollView!.headerStopOffsetHeight =  64
        
        return parallaxScrollView!;

    }
    
    func createColorCollectionView(){
        
        if collectionView == nil{
        
            flowLayout = UICollectionViewFlowLayout()
        
            collectionView = UICollectionView(frame: bottomView.bounds, collectionViewLayout: flowLayout)
            collectionView.contentInset = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
            collectionView.backgroundColor = UIColor.lightGrayColor()
            collectionView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            collectionView.delegate = self
            collectionView.dataSource = self
        
            collectionView?.registerNib(UINib(nibName: "ColorViewCell" , bundle:nil), forCellWithReuseIdentifier: "ColorViewCell")
            bottomView.addSubview(collectionView)
            
            bottomView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        }
        
        collectionView.reloadData()
    }
    
    func getColorCollectionViewHeight() -> Double{
    
       // let value = colorSwatchList.count / noOfColumns
        let noOfRows = 8 //(colorSwatchList.count % noOfColumns == 0) ? value : value + 1
        
        let colorItemWidth = getCellItemWidth(bottomView.bounds, columnCount: noOfColumns, spacing: spacing, inset :20)
        let colorItemHeight = colorItemWidth
        
        return Double(noOfRows)*colorItemHeight + (Double(noOfRows) - 1)*spacing

    }
    
    func addSearchController(){
    
        searchCtrl = SearchListViewController.init()
        view.addSubview(searchCtrl.view)
        
        let searchViewPosition = view.convertPoint(CGPoint.init(x: 0.0, y: CGRectGetMaxY(toolBar.frame)) , toView: view)
        var frame = searchCtrl.view.frame
        frame.origin = searchViewPosition
        searchCtrl.view.frame = frame
        
    }
    
    // MARK: - ToolBar delegate methods
    
    func clearSearch() {
        
        searchCtrl.view.removeFromSuperview()
    }
    
    func searchBarTextDidEndEditing(searchBar: CustomSearchBar!) {
        
    }
    
    func searchBarSearchButtonClicked(searchBar: CustomSearchBar!) {
        
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(searchBar: CustomSearchBar!){
    
        self.addSearchController()
    }

    // MARK: - IBAction methods
    
    @IBAction func openCamera(sender: AnyObject) {
        
        let colorMatchCtrl = ColorMatchViewController(nibName: "ColorMatchViewController", bundle: nil)
        self.navigationController?.pushViewController(colorMatchCtrl, animated: true)
        
    }
    
    @IBAction func openSearch(sender: AnyObject) {
        
    }
    
    @IBAction func openSettings(sender: AnyObject) {
        
    }

}

// MARK: -
extension ExploreColorViewController : UICollectionViewDataSource{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let colorList = colorSwatchList.objectAtIndex(self.selectedSwatchItemIndex)
        return colorList.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ColorViewCell", forIndexPath: indexPath) as? ColorViewCell
        let colorList = colorSwatchList.objectAtIndex(self.selectedSwatchItemIndex)
        if indexPath.row < colorList.count {
            cell?.backgroundColor = colorList.objectAtIndex(indexPath.row) as? UIColor
        }
        return cell!
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
//        if UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication().statusBarOrientation){
//            
//            return CGSizeMake(CGRectGetWidth(collectionView.bounds)/3 - LANDSCAPE_MARGIN_OFFSET*2 , CGRectGetHeight(collectionView.bounds) - LANDSCAPE_MARGIN_OFFSET*2)
//            
//        }
        
        let cellWidth = CGFloat(getCellItemWidth(bottomView.bounds, columnCount: noOfColumns, spacing: spacing, inset : 20.0))

        return CGSizeMake(cellWidth, cellWidth)
    }
    
}

// MARK: -
extension ExploreColorViewController : UICollectionViewDelegate{
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let colorDetail = ColorDetailOverlayViewController(nibName: "ColorDetailOverlayViewController", bundle: nil)
        colorDetail.colorViewed = (self.selectedContentItemIndex == indexPath.row) ? true : false
        
        let navCtrl = UINavigationController(rootViewController: colorDetail)
        navCtrl.navigationBarHidden = true
        
        navCtrl.view.frame = self.view.bounds
        navCtrl.transitioningDelegate = self
        navCtrl.modalPresentationStyle = .Custom
        
        self.selectedContentItemIndex = indexPath.row

        self.presentViewController(navCtrl, animated: true, completion: nil)
        
    }
}

// MARK: -
extension ExploreColorViewController : ColorSwatchViewDelegate{

    func updateContent(index : Int) {
        
        self.selectedSwatchItemIndex = index
        self.collectionView.reloadData()
    }
}

// MARK: -
extension ExploreColorViewController : UIViewControllerTransitioningDelegate {

    func animationControllerForPresentedController(
        presented: UIViewController,
        presentingController presenting: UIViewController,
                             sourceController source: UIViewController) ->
        UIViewControllerAnimatedTransitioning? {
            
            let contentCell = self.collectionView.cellForItemAtIndexPath(NSIndexPath(forRow: self.selectedContentItemIndex, inSection: 0))
            
            transition.originFrame = contentCell!.superview!.convertRect(contentCell!.frame, toView: nil)
            transition.presenting = true
            
            return transition
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = false
        return transition
    }

}
