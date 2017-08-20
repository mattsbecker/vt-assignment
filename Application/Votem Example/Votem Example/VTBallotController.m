//
//  VTBallotController.m
//  Votem Example
//
//  Created by Matt on 8/19/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import "VTBallotController.h"
#import "VTSelectOneBallot.h"
#import "VTSelectTwoBallot.h"
#import "VTRankedChoiceBallot.h"

@interface VTBallotController()

@property(nonatomic, strong) VTBallot *ballot;

@end

@implementation VTBallotController

- (instancetype)initWithBallot:(VTBallot *)ballot {
    self = [super init];
    self.ballot = ballot;
    return self;
}

- (NSArray<VTBallotOption*>*)applySelection:(VTBallotOption*)ballotOption {
    return nil;
}

- (NSArray<VTBallotOption*>*)handleSelection:(VTBallotOption *)selection {
    if (self.ballot.type == kVTBallotTypeSelectOne) {
        [self handleSelectOneSelection:selection];
    } else if (self.ballot.type == kVTBallotTypeSelectTwo) {
        
    } else if (self.ballot.type == kVTBallotTypeRankedChoice) {
        
    } else {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Attempted to handle selection on a ballot with no type" userInfo:nil];
    }
    return nil;
}

- (NSArray<VTBallotOption*>*)handleSelectOneSelection:(VTBallotOption *)selection {
    __weak VTSelectOneBallot *selectOneBallot = (VTSelectOneBallot*)self.ballot;
    [selectOneBallot selectOption:selection];
    return self.ballot.selections;
}

- (NSArray<VTBallotOption*>*)handleSelectTwoSelection:(VTBallotOption *)selection {
    return self.ballot.selections;
    
    
}

- (NSArray<VTBallotOption*>*)handleSelectRankedChoice:(VTBallotOption *)selection {
    
    return nil;
}

- (NSArray<VTBallotOption*>*)handleSelectRankedChoiceReorder:(VTBallotOption *)selection {
    
    return nil;
}


@end
