//
//  VTContestsViewCoordinator.h
//  Votem Example
//
//  Created by Matt on 8/16/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import "VTTableViewCoordinator.h"
#import "VTContest.h"

@class VTRankedChoiceBallot;
@class VTSelectOneBallot;
@class VTSelectTwoBallot;


@interface VTContestsViewCoordinator : VTTableViewCoordinator
@property (nonatomic, strong) NSArray<VTContest *> *contests;
@end
