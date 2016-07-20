//
//  MyProject.swift
//  ColorSmart
//
//  Created by David on 19/07/16.
//  Copyright © 2016 Behr. All rights reserved.
//

import UIKit

class MyProject: NSObject {

    var name : String?
    var detail : [AnyObject] = []
}

class Color: NSObject {
    
    var key : String?
    var value : UIColor?
    var title : String?
    var subTitle : String?
    var cordinatedPalette : CordinatedPalette?
}

class CordinatedPalette: NSObject {
    
    var color1 : Color?
    var color2 : Color?
    var color3 : Color?
    var color4 : Color?

}

class PaintEstimation: NSObject {
    
    var key : String?
    var areaName : String?
    var quantity : Int = 0
}