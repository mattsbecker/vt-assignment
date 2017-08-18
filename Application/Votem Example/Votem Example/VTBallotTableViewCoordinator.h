//
//  VTBallotTableViewCoordinator.h
//  Votem Example
//
//  Created by Matt on 8/18/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import "VTTableViewCoordinator.h"
#import "VTContest.h"

@interface VTBallotTableViewCoordinator : VTTableViewCoordinator

-(instancetype)initWithContest:(VTContest *)contest;

@end
