//
//  VTContest.m
//  Votem Example
//
//  Created by Matt on 8/16/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import "VTContest.h"

@implementation VTContest
@synthesize completed = _completed;

- (NSDictionary<NSString*, NSNumber*> *)evaluateContestCompletionStatus {
    NSInteger completedCount = 0;
    NSInteger avaialbleCount = self.availableBallots.count;
    
    BOOL isComplete = YES;
    for (VTBallot *ballot in self.availableBallots) {
        if (ballot.enabled && ballot.submittable) {
            completedCount += 1;
            continue;
        } else {
            isComplete = NO;
        }
    }
    self.completed = isComplete;
    NSDictionary *result = @{@"completed" : @(completedCount), @"available" : @(avaialbleCount), @"isComplete" : @(self.completed)};
    return result;
}

- (void)setCompleted:(BOOL)completed {
    _completed = completed;
}

@end
