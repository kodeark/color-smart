//
//  ColorFamilyView.swift
//  ColorSmart
//
//  Created by David on 10/06/16.
//  Copyright © 2016 Behr. All rights reserved.
//

import UIKit

class ColorFamilyView: UIView {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var middleColorView: UIView!
    
    var contentMovedToCenterPosition : Bool = false
    var colorArray : NSMutableArray!
    
    class func instanceFromNib() -> ColorFamilyView {
        
        let view = UINib(nibName: "ColorFamilyView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! ColorFamilyView
        view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        return view
    }

    func updateScrollView(colorList: NSMutableArray) {
        
        self.colorArray = colorList
        
        let path = UIBezierPath(roundedRect:middleView.bounds, byRoundingCorners:[.TopLeft, .TopRight], cornerRadii: CGSizeMake(25,25))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.CGPath
        middleView.layer.mask = maskLayer

        scrollView.contentInset = UIEdgeInsetsMake(0.0, 15.0, 0.0, 15.0)

        let separatorValue  = 20
        let itemCount = colorList.count
        
        let itemHeight = CGRectGetHeight(scrollView.bounds)
        let itemWidth = itemHeight
      
        let scrollContentWidth = (CGFloat(itemCount) * itemWidth) + (CGFloat(itemCount - 1) * CGFloat(separatorValue)) //20.0 is separator value
        scrollView.contentSize = CGSizeMake(scrollContentWidth, CGRectGetHeight(scrollView.bounds))
        
        var xPosition = 0.0
        for index in 0 ..< itemCount {
            
            let imageBtn = UIButton(frame: CGRectMake(CGFloat(xPosition), 0.0, CGFloat(itemWidth), itemHeight))
            imageBtn.backgroundColor = colorList.objectAtIndex(index) as? UIColor
            imageBtn.layer.cornerRadius = 20
            imageBtn.clipsToBounds = true
            scrollView.addSubview(imageBtn)
            
            xPosition = xPosition + Double(itemWidth) + Double(separatorValue)
        }
        
        middleColorView.layer.cornerRadius = 20
        middleColorView.clipsToBounds = true

        updateCenterRect()
        
    }

}

extension ColorFamilyView : UIScrollViewDelegate{
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
        UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
            
            self.contentMovedToCenterPosition = false
            
            
            }, completion: { finished in
                
        })
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
            
            self.scrollingStopped()

            
            }, completion: { finished in
                
        })
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        
        UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
            
            self.scrollingStopped()

            
            }, completion: { finished in
                
        })

    }
    
    func scrollingStopped(){
        
        if !contentMovedToCenterPosition {
            
            updateCenterRect()
            contentMovedToCenterPosition = true

        }
        
    }
    
    func updateCenterRect(){
    
        NSLog("offset position is:%f", NSStringFromCGPoint(scrollView.contentOffset))
        let subViewArray = scrollView.subviews
        
        for index in 0..<subViewArray.count{
        
            let obj = subViewArray[index]
            
            if obj.isKindOfClass(UIButton) {
            
                let rect = convertRect(obj.frame, toView: self)
            
                if middleView.frame.contains(CGPointMake(rect.minX, rect.minY)){
            
                    middleColorView.backgroundColor = colorArray.objectAtIndex(index) as? UIColor
                    
                    if !CGRectEqualToRect(rect, CGRectZero){
                        
                        self.scrollView.scrollRectToVisible(rect, animated: false)
                        
                        
                    }

                    break
                }
            }
        
        }
    }
    

}

