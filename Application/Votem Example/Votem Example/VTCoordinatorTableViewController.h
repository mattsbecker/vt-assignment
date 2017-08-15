//
//  VTCoordinatorTableViewController.h
//  Votem Example
//
//  Created by Matt on 8/14/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VTTableViewCoordinator.h"
#import "VTTableViewCell.h"

@interface VTCoordinatorTableViewController : UITableViewController<VTTableViewCoordinatorDelegate>

- (instancetype)initWithCoordinator:(VTTableViewCoordinator*)coordinator;
+ (NSString *)nibNamed;

@end
