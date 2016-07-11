//
//  ColorSwatchView.swift
//  ColorSmart
//
//  Created by David on 8/06/16.
//  Copyright © 2016 Behr. All rights reserved.
//

import UIKit

@objc
protocol ColorSwatchViewDelegate {
    
    optional func updateContent(index : Int)
}

class ColorSwatchView: UIView {
    
    @IBOutlet var swatchScrollView: UIScrollView!
    
    @IBOutlet weak var topLine: UIView!
    @IBOutlet weak var bottomLine: UIView!
    
    var delegate : ColorSwatchViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    class func instanceFromNib() -> ColorSwatchView {
        
        let view = UINib(nibName: "ColorSwatchView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! ColorSwatchView
        view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        return view
    }
    
    func updateScrollView(colorList: NSMutableArray) {
                
        swatchScrollView.backgroundColor = UIColor.clearColor()
        swatchScrollView.contentInset = UIEdgeInsetsMake(0.0, 10.0, 0.0, 10.0)
        
       // let visibleSwatchCount = 5
        let separatorValue  = 10
        let itemCount = colorList.count
        let itemHeight = swatchScrollView.frame.height
        let itemWidth = itemHeight
//        let itemWidth = (Float(CGRectGetWidth(swatchScrollView.bounds)) - Float((visibleSwatchCount - 1)*separatorValue))/6
//        let itemHeight = swatchScrollView.bounds.height
        let scrollContentWidth = (CGFloat(itemCount) * itemWidth) + (CGFloat(itemCount - 1) * CGFloat(separatorValue)) //20.0 is separator value
        swatchScrollView.contentSize = CGSizeMake(scrollContentWidth, CGRectGetHeight(swatchScrollView.frame))
        
        var xPosition = 0.0
        for i in 0 ..< colorList.count {
            
            let imageBtn = UIButton(frame: CGRectMake(CGFloat(xPosition), 0.0, CGFloat(itemWidth), itemHeight))
            imageBtn.tag = i
            imageBtn.addTarget(self, action:#selector(buttonTapped(_:)), forControlEvents:.TouchUpInside)
            createSwatchItemView(i , imageBtn: imageBtn, colorArray: colorList.objectAtIndex(i) as! NSArray)
            swatchScrollView.addSubview(imageBtn)
            
            if i == 0 {
                imageBtn.backgroundColor = UIColor.grayColor()
                
            }
            
            xPosition = xPosition + Double(itemWidth) + Double(separatorValue)
        }

    }
    
    func createSwatchItemView(index : Int, imageBtn : UIButton, colorArray : NSArray){
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            
            let noOfColumns = 5
           
            //let value = colorArray.count / noOfColumns
            let noOfRows = 5 //(colorArray.count % noOfColumns == 0) ? value : value + 1 fixed the number of rows and columns to avoid size of the colors from varying in each swatch.
            let padding = 4.0
            let imageBtnWidth = Double(CGRectGetWidth(imageBtn.bounds))
            let colorItemWidth = 16.0 //floor((imageViewWidth - Double((noOfColumns - 1))*spacing)/Double(noOfColumns))
            let colorItemHeight = colorItemWidth
            let spacing = (imageBtnWidth - (colorItemWidth * Double(noOfColumns)) - padding * 2)/Double(noOfColumns - 1)
            
            
            UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageBtn.bounds.size.width, imageBtn.bounds.size.height), false, 0)
            let ctx = UIGraphicsGetCurrentContext()
            
            var yPosition:Double = padding
            for row in 0 ..< noOfRows {
                
                var xPosition : Double = padding
                
                for column in 0 ..< noOfColumns{
                    
                    let index = row*noOfColumns + column
                    if(index < colorArray.count){
                        
                        let fillColor : UIColor = colorArray.objectAtIndex(index) as! UIColor
                        CGContextSetFillColorWithColor(ctx, fillColor.CGColor)
                        
                        let rect = CGRectMake(CGFloat(xPosition), CGFloat(yPosition), CGFloat(colorItemWidth), CGFloat(colorItemHeight))
                        // inset the rect because half of the stroke applied to this path will be on the outside
                        
                        // get our rounded rect as a path
                        let path = createRoundedCornerPath(rect, cornerRadius: 3.0);
                        
                        // add the path to the context
                        CGContextAddPath(ctx, path);
                        
                        //CGContextAddEllipseInRect(ctx, CGRectMake(CGFloat(xPosition), CGFloat(yPosition), CGFloat(colorItemWidth), CGFloat(colorItemHeight)))
                        CGContextDrawPath(ctx, CGPathDrawingMode.Fill)
                        
                        
                        xPosition = xPosition + Double(colorItemWidth) + spacing
                        
                    }
                    
                }
                
                yPosition = yPosition + Double(colorItemHeight) + spacing
                
            }
            
            let img =  UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                imageBtn.setImage(img, forState: UIControlState.Normal)
            })
        })
        
    }
    
    func buttonTapped(sender : UIButton){
    
        delegate?.updateContent!(sender.tag)
    }

}

extension ColorSwatchView : UIScrollViewDelegate{

    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
        UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
            
            var frame = self.topLine.bounds
            frame.size.width = 40
            self.topLine.bounds = frame
            
            self.bottomLine.bounds = frame
            
            }, completion: { finished in
                
        })
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        scrollingStopped()
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if !decelerate{
        
            scrollingStopped()
        }
    }
    
    func scrollingStopped(){
    
        UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
            
            var frame = self.topLine.bounds
            frame.size.width = self.swatchScrollView.frame.height //To make the width of lines same as individual swatch width
            self.topLine.bounds = frame
            
            self.bottomLine.bounds = frame
            
            }, completion: { finished in
                
        })

    }

}
