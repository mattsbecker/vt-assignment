//
//  UIFont+VTFonts.m
//  Votem Example
//
//  Created by Matt on 8/13/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import "UIFont+VTFonts.h"

@implementation UIFont (VTFonts)

+ (UIFont *)vt_standardContentFont {
    return [UIFont systemFontOfSize:16.0 weight:UIFontWeightRegular];
}

+ (UIFont *)vt_formFieldFont {
    return [UIFont systemFontOfSize:14.0 weight:UIFontWeightSemibold];
}

+ (UIFont *)vt_footnoteFont {
    return [UIFont systemFontOfSize:11.0 weight:UIFontWeightLight];
}

@end
