//
//  UIColor+VTColors.m
//  Votem Example
//
//  Created by Matt on 8/13/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import "UIColor+VTColors.h"

@implementation UIColor (VTColors)
+ (UIColor *)vt_primaryBrandColor {
    return [UIColor colorWithRed:0.0/255.0 green:42.0/255.0 blue:74.0/255.0 alpha:1.0];
}

+ (UIColor *)vt_secondaryBrandColor {
    return [UIColor colorWithRed:102.0/255.0 green:117.0/255.0 blue:128.0/255.0 alpha:1.0];
}

+ (UIColor *)vt_tertiaryBrandColor {
    return [UIColor colorWithRed:153.0/255.0 green:159.0/255.0 blue:164.0/255.0 alpha:1.0];
}

+ (UIColor *)vt_highlightBrandColor {
    return [UIColor colorWithRed:253/255.0 green:146/255.0 blue:43/255.0 alpha:1.0];
}

+ (UIColor *)vt_lightTextColor {
    return [UIColor colorWithWhite:0.45 alpha:1.0];
}

@end
