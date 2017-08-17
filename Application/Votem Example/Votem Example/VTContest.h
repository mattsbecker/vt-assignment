//
//  VTContest.h
//  Votem Example
//
//  Created by Matt on 8/16/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import "VTTableViewCoordinator.h"
#import "VTBallot.h"


@interface VTContest : NSObject

@property (nonatomic, assign) NSInteger contestId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;
@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, strong) NSArray<VTBallot*> *availableBallots;

@end
