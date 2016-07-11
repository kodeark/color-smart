//
//  Helper.swift
//  ColorSmart
//
//  Created by David on 26/05/16.
//  Copyright © 2016 Behr. All rights reserved.
//

import Foundation

func isiPad() -> Bool {
    
    return (UIDevice.currentDevice().userInterfaceIdiom == .Pad)
    
}

func isiPhone() -> Bool {
    
    return (UIDevice.currentDevice().userInterfaceIdiom == .Phone)

}

func createRoundedCornerPath(rect : CGRect, cornerRadius :CGFloat) -> CGMutablePathRef {
    
    // create a mutable path
    let path = CGPathCreateMutable();
    
    // get the 4 corners of the rect
    let topLeft = CGPointMake(rect.origin.x, rect.origin.y);
    let topRight = CGPointMake(rect.origin.x + rect.size.width, rect.origin.y);
    let bottomRight = CGPointMake(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
    let bottomLeft = CGPointMake(rect.origin.x, rect.origin.y + rect.size.height);
    
    // move to top left
    CGPathMoveToPoint(path, nil, topLeft.x + cornerRadius, topLeft.y);
    
    // add top line
    CGPathAddLineToPoint(path, nil, topRight.x - cornerRadius, topRight.y);
    
    // add top right curve
    CGPathAddQuadCurveToPoint(path, nil, topRight.x, topRight.y, topRight.x, topRight.y + cornerRadius);
    
    // add right line
    CGPathAddLineToPoint(path, nil, bottomRight.x, bottomRight.y - cornerRadius);
    
    // add bottom right curve
    CGPathAddQuadCurveToPoint(path, nil, bottomRight.x, bottomRight.y, bottomRight.x - cornerRadius, bottomRight.y);
    
    // add bottom line
    CGPathAddLineToPoint(path, nil, bottomLeft.x + cornerRadius, bottomLeft.y);
    
    // add bottom left curve
    CGPathAddQuadCurveToPoint(path, nil, bottomLeft.x, bottomLeft.y, bottomLeft.x, bottomLeft.y - cornerRadius);
    
    // add left line
    CGPathAddLineToPoint(path, nil, topLeft.x, topLeft.y + cornerRadius);
    
    // add top left curve
    CGPathAddQuadCurveToPoint(path, nil, topLeft.x, topLeft.y, topLeft.x + cornerRadius, topLeft.y);
    
    // return the path
    return path;
}

func getCellItemWidth(rect : CGRect, columnCount : Int, spacing : Double, inset : Double) -> Double{

    return floor((Double(rect.size.width) - Double((columnCount - 1))*spacing - inset)/Double(columnCount))

}

func image(fillColor : UIColor, strokeColor : UIColor) -> UIImage{

    let rect = CGRectMake(0.0, 0.0, 1.0, 1.0)
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()
    
    CGContextSetFillColorWithColor(context, fillColor.CGColor)
    CGContextSetStrokeColorWithColor(context, strokeColor.CGColor)
    
    CGContextFillRect(context, rect)
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return image
}