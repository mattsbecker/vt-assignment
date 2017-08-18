//
//  VTSelectOneBallot.m
//  Votem Example
//
//  Created by Matt on 8/16/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import "VTSelectOneBallot.h"

@implementation VTSelectOneBallot
@synthesize instructions = _instructions;
@synthesize subtitle = _subtitle;
@synthesize ballotNote = _ballotNote;

- (instancetype) init {
    self = [super init];
    self.type = kVTBallotTypeSelectOne;
    return self;
}

@end
