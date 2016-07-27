//
//  TopIconButton.swift
//  ColorSmart
//
//  Created by David on 1/07/16.
//  Copyright © 2016 Behr. All rights reserved.
//

import UIKit

class TopIconButton: UIButton {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let kTextTopPadding:CGFloat = 3.0;
        
        var titleLabelFrame = self.titleLabel!.frame;
        
        
        let labelSize = titleLabel!.sizeThatFits(CGSizeMake(CGRectGetWidth(self.contentRectForBounds(self.bounds)), CGFloat.max))
        
        var imageFrame = self.imageView!.frame;
        
        let fitBoxSize = CGSizeMake(max(imageFrame.size.width, labelSize.width), labelSize.height + kTextTopPadding + imageFrame.size.height)
        
        let fitBoxRect = CGRectInset(self.bounds, (self.bounds.size.width - fitBoxSize.width)/2, (self.bounds.size.height - fitBoxSize.height)/2);
        
        imageFrame.origin.y = fitBoxRect.origin.y;
        imageFrame.origin.x = CGRectGetMidX(fitBoxRect) - (imageFrame.size.width/2);
        self.imageView!.frame = imageFrame;
        
        // Adjust the label size to fit the text, and move it below the image
        
        titleLabelFrame.size.width = labelSize.width;
        titleLabelFrame.size.height = labelSize.height;
        titleLabelFrame.origin.x = (self.frame.size.width / 2) - (labelSize.width / 2);
        titleLabelFrame.origin.y = fitBoxRect.origin.y + imageFrame.size.height + kTextTopPadding;
        self.titleLabel!.frame = titleLabelFrame;
        self.titleLabel!.textAlignment = .Center
    }

}
