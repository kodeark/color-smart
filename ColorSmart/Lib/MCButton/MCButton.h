//
//  MCButton.h
//  MCButton
//
//  Created by Anup D'Souza on 09/07/14.
//  Copyright (c) 2014 Anup D'Souza. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface UIImage (ImageWithColor)
+ (UIImage *)imageWithColor:(UIColor *)color;
@end

@interface MCButton : UIButton

- (void)buttonWithText:(NSString*)text font:(UIFont*)font fontColor:(UIColor*)fontColor iconImage:(UIImage*)image backgroundColor:(UIColor*)bgColor useHighlights:(BOOL)highlights;

- (void)setUsesHighlights:(BOOL)highlights;
- (void)setBackgroundColor:(UIColor*)backgroundColor;
- (void)setHighlightColor:(UIColor*)highlightColor;
- (void)setTextFont:(UIFont*)textFont;
- (void)setTextColor:(UIColor*)textColor;
- (void)setHighlightTextColor:(UIColor*)highlightTextColor;
- (void)setIconImage:(UIImage*)iconImage;
- (void)setHighlightImage:(UIImage*)highlightImage;
- (void)setSelectedImage:(UIImage*)selectedImage;
- (void)setImageTextSpacing:(CGFloat)spacing;
- (void)setContentEdgeSpacing:(CGFloat)spacing;
- (void)setCornerRadius:(CGFloat)radius;
- (void)setDefaultBorderColor;
- (void)setButtonFrame:(CGRect)frame;
- (void)setImageTintColor:(UIColor *)tintColor;

@end