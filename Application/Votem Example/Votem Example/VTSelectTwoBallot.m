//
//  VTSelectTwoBallot.m
//  Votem Example
//
//  Created by Matt on 8/16/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import "VTSelectTwoBallot.h"

@implementation VTSelectTwoBallot
@dynamic instructions;

- (instancetype) init {
    self = [super init];
    self.type = kVTBallotTypeSelectTwo;
    return self;
}

@end
