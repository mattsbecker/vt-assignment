//
//  UIFont+VTTableViewCells.m
//  Votem Example
//
//  Created by Matt on 8/14/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import "UITableViewCell+VTTableViewCells.h"

@implementation UITableViewCell (VTTableViewCells)

+ (NSString *)vt_reuseIdentifier {
    return NSStringFromClass([self class]);
}

+ (UINib *)vt_tableViewCellNib {
    NSString *classString = NSStringFromClass([self class]);
    return [UINib nibWithNibName:classString bundle:nil];
}

@end
