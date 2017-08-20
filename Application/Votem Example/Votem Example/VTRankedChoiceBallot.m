//
//  VTRankedChoiceBallot.m
//  Votem Example
//
//  Created by Matt on 8/16/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import "VTRankedChoiceBallot.h"

@interface VTRankedChoiceBallot()
@property (nonatomic, strong) NSMutableArray<VTBallotOption*> *mutableSelections;
@end

@implementation VTRankedChoiceBallot
@synthesize instructions = _instructions;
@synthesize subtitle = _subtitle;
@synthesize ballotNote = _ballotNote;

- (instancetype) init {
    self = [super init];
    self.type = kVTBallotTypeRankedChoice;
    self.allowedNumberOfSelections = self.selections.count;
    self.mutableSelections = [NSMutableArray arrayWithCapacity:self.allowedNumberOfSelections];
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
    self.submittable = [self evaluateSubmittable];
    // Determine if this ballot is submittable – for this type, if the selections does not equal the allowedNumberOfSelections, it cannot be submitted
}

- (void)deselectOption:(VTBallotOption *)option {
    if ([self.mutableSelections containsObject:option]) {
        [self.mutableSelections removeObject:option];
        [self rebaseSelections];
    }
    self.selections = [NSArray arrayWithArray:self.mutableSelections];
    self.submittable = [self evaluateSubmittable];
}

- (void)moveSelection:(VTBallotOption*)option fromPosition:(NSInteger)fromPostition toPosition:(NSInteger)toPosition {
    if (![self.options containsObject:option]) {
        // If for some reason the selection isn't actually in our array, break out of here now
        return;
    }
    
    if (toPosition > self.options.count - 1) {
        // If the new position doesn't yet exist in our array, get out of here now 
        return;
    }
    
    // We need to reorder the options, given that this is our canonical data source
    NSMutableArray<VTBallotOption*> *mutableOptions = [NSMutableArray arrayWithArray:self.options];
    [mutableOptions exchangeObjectAtIndex:fromPostition withObjectAtIndex:toPosition];

    self.options = [NSArray arrayWithArray:mutableOptions];
    self.submittable = [self evaluateSubmittable];
}

- (void)removeWriteInSelection:(VTBallotOption*)option {
    [self.mutableSelections removeObject:option];
    NSMutableArray<VTBallotOption*> *mutableOptions = [NSMutableArray arrayWithArray:self.options];
    [mutableOptions removeObject:option];
    self.selections = [NSArray arrayWithArray:self.mutableSelections];
    self.options = [NSArray arrayWithArray:mutableOptions];
}

- (void)prepareForWriteInAdditionWithText:(NSString *)text {
    // Create a mutable array for storing changes and create our new ballot option
    NSMutableArray<VTBallotOption*> *mutableOptions = [NSMutableArray arrayWithArray:self.options];
    VTBallotOption *writeInBallotOption = [[VTBallotOption alloc] init];
    writeInBallotOption.title = text;
    writeInBallotOption.writeIn = YES;
    
    // Add the ballot option to the selections and the options
    [mutableOptions addObject:writeInBallotOption];
    [self.mutableSelections addObject:writeInBallotOption];
    
    self.options = [NSArray arrayWithArray:mutableOptions];
    self.selections = [NSArray arrayWithArray:self.mutableSelections];
}

- (BOOL)evaluateSubmittable {
    if (self.selections.count > 0) {
        return YES;
    } else {
        return NO;
    }
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
    NSUInteger max = self.allowedNumberOfSelections;
    if (self.selections.count <= (max - 1)) {
        return self.selections.count;
    } else if (self.selections.count == max - 1) {
        return 0;
    } else {
        return 0;
    }
}

@end
