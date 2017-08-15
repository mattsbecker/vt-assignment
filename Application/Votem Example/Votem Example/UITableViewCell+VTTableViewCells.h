//
//  UIFont+VTTableViewCells.h
//  Votem Example
//
//  Created by Matt on 8/14/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (VTTableViewCells)

+ (NSString *)vt_reuseIdentifier;
+ (UINib *)vt_tableViewCellNib;

@end
