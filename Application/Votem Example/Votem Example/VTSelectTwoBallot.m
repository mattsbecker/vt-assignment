//
//  VTSelectTwoBallot.m
//  Votem Example
//
//  Created by Matt on 8/16/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import "VTSelectTwoBallot.h"

@interface VTSelectTwoBallot()
@property (nonatomic, strong) NSMutableArray<VTBallotOption*> *mutableSelections;
@end

@implementation VTSelectTwoBallot
@synthesize instructions = _instructions;
@synthesize subtitle = _subtitle;
@synthesize ballotNote = _ballotNote;

- (instancetype) init {
    self = [super init];
    self.mutableSelections = [NSMutableArray<VTBallotOption*> arrayWithCapacity:2];
    self.type = kVTBallotTypeSelectTwo;
    return self;
}

- (void)selectOption:(VTBallotOption *)option {
    // If there are less than two selections, go ahead and just add the new selection to the array

    if ([self.selections containsObject:option]) {
        return;
    }

    // Get the next available index
    NSInteger nextIndex = [self nextAvaliableSelectionIndex];
    
    // Determine if the mutableSections array contains an index that could be replaced; If there is already an object at this index, replace it
    if (self.mutableSelections.count != 0 && self.mutableSelections.count >= nextIndex + 1) {
        [self.mutableSelections replaceObjectAtIndex:nextIndex withObject:option];
    } else {
    // Otherwise insert the object at the new index
        [self.mutableSelections addObject:option];
    }
    self.selections = [NSArray arrayWithArray:self.mutableSelections];
}

- (void)deselectOption:(VTBallotOption *)option {
    if ([self.mutableSelections containsObject:option]) {
        [self.mutableSelections removeObject:option];
        [self rebaseSelections];
    }
    self.selections = [NSArray arrayWithArray:self.mutableSelections];
}

// Reindex the array after the removal of a selection, shifting any post-nil objects back one index
- (void)rebaseSelections {
    BOOL needsRebase = NO;
    NSInteger rebaseFrom = 0;

    for (NSInteger i = 0; i < self.mutableSelections.count; i++) {
        if (i != self.mutableSelections.count) {
            if (self.mutableSelections[i] == nil) {
                needsRebase = YES;
                rebaseFrom = i;
            }
        }
    }
    if (needsRebase && rebaseFrom != 0) {
        for (NSInteger i = rebaseFrom; i < self.mutableSelections.count; i++) {
            if (i != self.mutableSelections.count) {
                [self.mutableSelections replaceObjectAtIndex:i withObject:self.mutableSelections[i + 1]];
            }
        }
    }
}

// Retrieves the next index that's available for selection insertion; uses a round-robin style selection style
- (NSInteger)nextAvaliableSelectionIndex {
    NSUInteger max = 2;
    if (self.selections.count <= (max - 1)) {
        return self.selections.count;
    } else if (self.selections.count == max - 1) {
        return 0;
    } else {
        return 0;
    }
}

@end
