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
    self.allowedNumberOfSelections = 1;
    self.selections = [[NSArray<VTBallotOption *> alloc] init];
    self.options = [NSArray array];
    return self;
}

- (void)selectOption:(VTBallotOption *)option {
    // Given this is a select-one ballot type, the "selections" for this ballot will can only ever contain one selection
    if (![self.selections containsObject:option]) {
        self.selections = @[option];
    }
    self.submittable = [self evaluateSubmittable];
}

- (void)deselectOption:(VTBallotOption *)option {
    if ([self.selections containsObject:option]) {
        self.selections = @[];
    }
    self.submittable = [self evaluateSubmittable];
}

- (BOOL)evaluateSubmittable {
    if (self.selections.count == self.allowedNumberOfSelections) {
        return YES;
    } else {
        return NO;
    }
}

@end
