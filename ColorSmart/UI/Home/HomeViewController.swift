//
//  HomeViewController.swift
//  ColorSmart
//
//  Created by David on 26/05/16.
//  Copyright © 2016 Behr. All rights reserved.
//

import UIKit

class HomeViewController: CenterViewController {

    let homeItems = ["Choose a Color","Get Inspired","My Projects"]
    let LANDSCAPE_MARGIN_OFFSET : CGFloat = 10.0
    let PORTRAIT_MARGIN_OFFSET : CGFloat = 6.0
    
    var collectionView : UICollectionView!
    var flowLayout : UICollectionViewLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.addNavigationBarOnView(self.view)
        createCollectionView()

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createCollectionView(){
    
        flowLayout = UICollectionViewFlowLayout()
        
        let navigationBarHeight = CGRectGetMaxY(navigationBarView.frame)
        let frame = CGRect(x: 0.0, y: navigationBarHeight, width: CGRectGetWidth(view.bounds), height: CGRectGetHeight(view.bounds) - navigationBarHeight)
        collectionView = UICollectionView(frame: frame, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.lightGrayColor()
        collectionView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        collectionView.delegate = self
        collectionView.dataSource = self
        
        updateContentInsetForOrientation(UIApplication.sharedApplication().statusBarOrientation)

        collectionView?.registerNib(UINib(nibName: "HomeCollectionViewCell" , bundle:nil), forCellWithReuseIdentifier: "HomeViewCell")
        self.view.addSubview(collectionView)
    }
    
    func updateContentInsetForOrientation(interfaceOrientation: UIInterfaceOrientation){
    
        if UIInterfaceOrientationIsLandscape(interfaceOrientation){
            collectionView.contentInset = UIEdgeInsets(top: LANDSCAPE_MARGIN_OFFSET, left: LANDSCAPE_MARGIN_OFFSET, bottom: LANDSCAPE_MARGIN_OFFSET, right: LANDSCAPE_MARGIN_OFFSET)
        }else{
            collectionView.contentInset = UIEdgeInsets(top: PORTRAIT_MARGIN_OFFSET, left: PORTRAIT_MARGIN_OFFSET, bottom: PORTRAIT_MARGIN_OFFSET, right: PORTRAIT_MARGIN_OFFSET)
        }
    
    }
    
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        
        updateContentInsetForOrientation(toInterfaceOrientation)
        flowLayout.invalidateLayout()

    }
    
}

extension HomeViewController : UICollectionViewDataSource{

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeItems.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("HomeViewCell", forIndexPath: indexPath) as? HomeCollectionViewCell
        if isiPad() {
            cell?.titleLbl.font = UIFont.boldSystemFontOfSize(30.0)
        }
        cell?.titleLbl.text = homeItems[indexPath.row]
        return cell!
    }
    
}

extension HomeViewController : UICollectionViewDelegate{

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        switch indexPath.row {
        case 0:
            let exploreColorViewController = ExploreColorViewController(nibName: "ExploreColorViewController", bundle: nil)
            self.navigationController?.pushViewController(exploreColorViewController, animated: true)
            break
        case 1:
            let inspirationViewController = InspirationViewController(nibName: "InspirationViewController", bundle: nil)
            self.navigationController?.pushViewController(inspirationViewController, animated: true)
            break
        default:
            break
        }
    }
}

extension HomeViewController : UICollectionViewDelegateFlowLayout{

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        if UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication().statusBarOrientation){
            
            return CGSizeMake(CGRectGetWidth(collectionView.bounds)/3 - LANDSCAPE_MARGIN_OFFSET*2 , CGRectGetHeight(collectionView.bounds) - LANDSCAPE_MARGIN_OFFSET*2)
            
        }
        
        return CGSizeMake(CGRectGetWidth(collectionView.bounds) - PORTRAIT_MARGIN_OFFSET*2, CGRectGetHeight(collectionView.bounds)/3 - PORTRAIT_MARGIN_OFFSET*2)
    }

}

