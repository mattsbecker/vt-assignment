//
//  VTBallotListTableViewController.h
//  Votem Example
//
//  Created by Matt on 8/18/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import "VTCoordinatorTableViewController.h"
#import "VTContest.h"

@interface VTBallotListTableViewController : VTCoordinatorTableViewController
@property(nonatomic, strong) VTContest *contest;
@end
