//
//  MCButton.m
//  MCButton
//
//  Created by Anup D'Souza on 09/07/14.
//  Copyright (c) 2014 Anup D'Souza. All rights reserved.
//

#import "MCButton.h"

#import "UIImage+Tint.h"
#import "UIColor+Shades.h"

#define kDefaultFont [UIFont fontWithName:@"HelveticaNeue" size:15]
#define kDefaultFontColor [UIColor whiteColor]
#define kDefaultImageTextSpacing 10
#define kDefaultContentEdgeSpacing 0
#define kDefaultCornerRadius 5

/**
 * UIImage category to get an image from given
 * color that can be used to set as background
 * image for the button. This allows setting a
 * icon image for the button.
 */
@implementation UIImage (ImageWithColor)

+ (UIImage *)imageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end

@interface MCButton ()

@property (strong, nonatomic) UIColor *btnBackgroundColor;
@property (strong, nonatomic) UIColor *btnHighlightColor;
@property (strong, nonatomic) UIColor *btnNormalTextColor;
@property (strong, nonatomic) UIColor *btnHighlightTextColor;
@property (strong, nonatomic) UIFont *btnTextFont;
@property (strong, nonatomic) UIImage *btnNormalIconImage;
@property (strong, nonatomic) UIImage *btnHighlightIconImage;
@property (strong, nonatomic) UIImage *btnSelectedIconImage;
@property (strong, nonatomic) NSString *btnTitleText;
@property (assign, nonatomic) NSInteger btnCornerRadius;
@property (assign, nonatomic) CGFloat imageTextSpacing;
@property (assign, nonatomic) CGFloat contentEdgeSpacing;
@property (assign, nonatomic) CGRect btnFrame;
@property (assign, nonatomic) BOOL usesHighlights;

@end

@implementation MCButton

- (void)buttonWithText:(NSString*)text
                  font:(UIFont*)font
             fontColor:(UIColor*)fontColor
             iconImage:(UIImage*)image
       backgroundColor:(UIColor*)bgColor
         useHighlights:(BOOL)highlights {
    
    if([self.titleLabel.text length]) {
        // if set in xib
        _btnTitleText = self.titleLabel.text;
    } else {
        // use updated text
        _btnTitleText = text;
    }
    
    _usesHighlights = highlights;
    _btnTextFont = font;
    _btnNormalTextColor = fontColor;
    _btnFrame = CGRectZero;
    
    [self.titleLabel setFont:_btnTextFont?_btnTextFont:kDefaultFont];
    [self setTitle:_btnTitleText forState:UIControlStateNormal];
    [self setTitleColor:_btnNormalTextColor?_btnNormalTextColor:kDefaultFontColor forState:UIControlStateNormal];
    
    _btnBackgroundColor = bgColor ? bgColor : [UIColor clearColor];
    _btnNormalIconImage = image;
    
    [self setBackgroundImage:[UIImage imageWithColor:_btnBackgroundColor] forState:UIControlStateNormal];
    [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self setImage:_btnNormalIconImage forState:UIControlStateNormal];
    
    if(_usesHighlights) {
        //apply darker highlight text color
        [self setTitleColor:[_btnNormalTextColor darkerColor] forState:UIControlStateHighlighted];
    }
    
    [self updateDisplayLayout];
    
}

// Set highlights with colors if needed
- (void)setUsesHighlights:(BOOL)highlights {
    
    _usesHighlights = highlights;
    
    if(_usesHighlights) {
        //apply darker highlight background image
        // [self setBackgroundImage:[UIImage imageWithColor:[_btnBackgroundColor darkerColor]] forState:UIControlStateHighlighted];
        
        //apply darker highlight text color
        [self setTitleColor:[_btnNormalTextColor darkerColor] forState:UIControlStateHighlighted];
    } else {
        //clear highlight colors
        [self setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forState:UIControlStateHighlighted];
        [self setTitleColor:[UIColor clearColor] forState:UIControlStateHighlighted];
    }
}

// Set button background color if needed
- (void)setBackgroundColor:(UIColor*)backgroundColor {
    
    _btnBackgroundColor = backgroundColor;
    [self setBackgroundImage:[UIImage imageWithColor:_btnBackgroundColor] forState:UIControlStateNormal];
    
    if(_usesHighlights) {
        //apply darker highlight background image
        [self setBackgroundImage:[UIImage imageWithColor:[_btnBackgroundColor darkerColor]] forState:UIControlStateHighlighted];
    }
}

// Set highlighted background image if needed
// Defaults to darker shade of background image
- (void)setHighlightColor:(UIColor*)highlightColor {
    
    _btnHighlightColor = highlightColor;
    [self setBackgroundImage:[UIImage imageWithColor:_btnHighlightColor] forState:UIControlStateHighlighted];
}

// Set text font if needed
- (void)setTextFont:(UIFont*)textFont {
    
    _btnTextFont = textFont;
    [self.titleLabel setFont:_btnTextFont];
    [self updateDisplayLayout];
}

// Set button title text color if needed
- (void)setTextColor:(UIColor*)textColor {
    
    _btnNormalTextColor = textColor;
    [self setTitleColor:_btnNormalTextColor forState:UIControlStateNormal];
    
    if(_usesHighlights) {
        //apply darker highlight text color
        [self setTitleColor:[_btnNormalTextColor darkerColor] forState:UIControlStateHighlighted];
    }
}

// Set highlighted text color if needed
// Defaults to darker shade of text color
- (void)setHighlightTextColor:(UIColor*)highlightTextColor {
    
    _btnHighlightTextColor = highlightTextColor;
    [self setTitleColor:_btnHighlightTextColor forState:UIControlStateHighlighted];
}

// Set normal icon image
- (void)setIconImage:(UIImage*)iconImage {
    
    _btnNormalIconImage = iconImage;
    [self setImage:_btnNormalIconImage forState:UIControlStateNormal];
    [self updateDisplayLayout];
}

// Set highlighted icon image
- (void)setHighlightImage:(UIImage*)highlightImage {
    
    _btnHighlightIconImage = highlightImage;
    [self setImage:_btnHighlightIconImage forState:UIControlStateHighlighted];
}

// Set selected icon image
- (void)setSelectedImage:(UIImage*)selectedImage {
    
    _btnSelectedIconImage = selectedImage;
    [self setImage:_btnSelectedIconImage forState:UIControlStateSelected];
}

// Set spacing between the image & text title
- (void)setImageTextSpacing:(CGFloat)spacing {
    _imageTextSpacing = spacing;
    [self updateDisplayLayout];
}

// Set spacing between the button content & its edges
- (void)setContentEdgeSpacing:(CGFloat)spacing {
    _contentEdgeSpacing = spacing;
    [self updateDisplayLayout];
}

// Set corner radius
- (void)setCornerRadius:(CGFloat)radius {
    
    _btnCornerRadius = radius;
    self.layer.cornerRadius = _btnCornerRadius;
    self.layer.masksToBounds = YES;
}

// Set 1px border
- (void)setDefaultBorderColor {
    self.layer.borderColor = _btnNormalTextColor.CGColor;
    self.layer.borderWidth = 1.0;
}

// Set button custom frame
- (void)setButtonFrame:(CGRect)frame {
    
    _btnFrame = frame;
    [self updateDisplayLayout];
}

- (void)setImageTintColor:(UIColor *)tintColor{

    [self setImage:[_btnNormalIconImage tintedImageWithColor:tintColor] forState:UIControlStateNormal];
    if (_btnSelectedIconImage)
        [self setImage:[_btnSelectedIconImage tintedImageWithColor:tintColor] forState:UIControlStateSelected];
    
    if(_usesHighlights) {
        //apply darker highlight background image
        [self setImage:[_btnNormalIconImage tintedImageWithColor:[tintColor darkerColor]]
              forState:UIControlStateHighlighted];
    }
}

// update button sizing depending on icon, text & spacings
- (void)updateDisplayLayout {
    
    // required size for image & text display
    CGSize finalSize = CGSizeZero;
    
    // we have text
    if(_btnTitleText) {
        
        CGSize maxSize = CGSizeMake(MAXFLOAT, 44.0);
        CGSize txtSize = CGSizeZero;
        
        if([_btnTitleText respondsToSelector:@selector(sizeWithAttributes:)]) {
            // iOS >= 7.0
            txtSize = [_btnTitleText boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_btnTextFont?_btnTextFont:kDefaultFont} context:nil].size;
        }
        else {
            // iOS < 7.0
            txtSize = [_btnTitleText sizeWithFont:_btnTextFont?_btnTextFont:kDefaultFont constrainedToSize:maxSize lineBreakMode:self.titleLabel.lineBreakMode];
        }
        
        finalSize = CGSizeMake(txtSize.width+5, txtSize.height); // here 5 is small buffer added to ensure full text display
    }
    
    // we have image
    if(_btnNormalIconImage) {
        
        CGSize imgSize = _btnNormalIconImage.size;
        if(finalSize.height < imgSize.height)
            finalSize.height = imgSize.height;
        
        finalSize.width = finalSize.width + imgSize.width;
    } else {
        
        //_imageTextSpacing = 0;
        
        // if no image but we have text, reset title edge insets
        // to zero else a padding is seen on the left of text
        if(_btnTitleText) {
            self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        }
    }
    
    // if we have image & text, insert spacing [image]<space>[text]
    if(_btnTitleText && _btnNormalIconImage) {
        
        CGFloat imageTextEdgeSpacing = (_imageTextSpacing > 0)?_imageTextSpacing:kDefaultImageTextSpacing;
        self.titleEdgeInsets = UIEdgeInsetsMake(0, imageTextEdgeSpacing, 0, 0);
    }
    
    // set edge spacing for button content, defaults to zero
    CGFloat edgeSpacing = (_contentEdgeSpacing>0)?_contentEdgeSpacing:kDefaultContentEdgeSpacing;
    self.contentEdgeInsets = UIEdgeInsetsMake(edgeSpacing, edgeSpacing, edgeSpacing, edgeSpacing);
    
    // ensure content is always vertically center aligned
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    // get final size taking into account content + spacings
    CGFloat width = finalSize.width + self.titleEdgeInsets.left + (self.contentEdgeInsets.left*2);
    CGFloat height = finalSize.height + (edgeSpacing*2);
    
    if(CGRectEqualToRect(_btnFrame, CGRectZero)) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, height);
    } else {
        self.frame = _btnFrame;
    }
}

@end
