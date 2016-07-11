//
//  UIColor+Shades.m
//  CoreALC
//
//  Created by Anup D'Souza on 27/01/16.
//  Copyright © 2016 Moa Creative. All rights reserved.
//

#import "UIColor+Shades.h"

/**
 * UIColor categories to get lighter & darker
 * shades of  given color that can be used to
 * give various effects.
 */
@implementation UIColor (Shades)

- (UIColor *)lighterColor {
    
    CGFloat h, s, b, a;
    if ([self getHue:&h saturation:&s brightness:&b alpha:&a])
        return [UIColor colorWithHue:h
                          saturation:s
                          brightness:MIN(b * 1.3, 1.0)
                               alpha:a];
    return nil;
}

- (UIColor *)darkerColor {
    
    CGFloat h, s, b, a;
    if ([self getHue:&h saturation:&s brightness:&b alpha:&a])
        return [UIColor colorWithHue:h
                          saturation:s
                          brightness:b * 0.75
                               alpha:a];
    return nil;
}

@end