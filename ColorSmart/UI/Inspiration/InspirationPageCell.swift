//
//  InspirationPageCell.swift
//  ColorSmart
//
//  Created by David on 15/07/16.
//  Copyright © 2016 Behr. All rights reserved.
//

import UIKit

class InspirationPageCell : BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.whiteColor()
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    
    var inspirations: NSMutableArray?

    override func setupViews() {
        super.setupViews()
        
        collectionView.registerNib(UINib.init(nibName: "InspirationItemCell", bundle: nil), forCellWithReuseIdentifier: "InspirationItemCell")

        addSubview(collectionView)
        addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        addConstraintsWithFormat("V:|[v0]|", views: collectionView)
        
    }
    
    func updateInspiration(inspiration : NSMutableArray){
    
        inspirations = inspiration
        collectionView .reloadData()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return inspirations?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("InspirationItemCell", forIndexPath: indexPath) as! InspirationItemCell
        
        let item = inspirations![indexPath.row]
        cell.titleLbl.text = item.title
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let height = (frame.width - 16 - 16) * 9 / 16
        return CGSizeMake(frame.width, height + 16 + 88)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 25
    }

    
}
