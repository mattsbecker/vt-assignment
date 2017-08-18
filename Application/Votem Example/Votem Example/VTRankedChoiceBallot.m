//
//  VTRankedChoiceBallot.m
//  Votem Example
//
//  Created by Matt on 8/16/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import "VTRankedChoiceBallot.h"

@implementation VTRankedChoiceBallot
@synthesize instructions = _instructions;
@synthesize subtitle = _subtitle;
@synthesize ballotNote = _ballotNote;

- (instancetype) init {
    self = [super init];
    self.type = kVTBallotTypeRankedChoice;
    return self;
}

@end
