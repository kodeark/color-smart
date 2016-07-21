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
    
    var value : UIColor?
    var title : String?
    var subTitle : String?
}

class CordinatedPalette: NSObject {
    
   var values : [Color] = []

}

class PaintEstimation: NSObject {
    
    var surfaceName : String?
    var quantity : Int = 0
    var weight : Int = 0
}