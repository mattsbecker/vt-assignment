//
//  VTBallotFactory.m
//  Votem Example
//
//  Created by Matt on 8/18/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import "VTBallotFactory.h"
#import "VTRankedChoiceBallot.h"
#import "VTSelectOneBallot.h"
#import "VTSelectTwoBallot.h"

@implementation VTBallotFactory
+ (VTBallot *)ballotWithType:(VTBallotType)type
                       title:(NSString *)title
                    subTitle:(NSString *)subtitle
                instructions:(NSString *)instructions
                  ballotNote:(NSString *)ballotNote
                     options:(NSArray *)options {
    
    VTBallot *ballot;
    
    if (type == kVTBallotTypeSelectOne) {
        VTSelectOneBallot *selectOneBallot = [[VTSelectOneBallot alloc] init];
        ballot = selectOneBallot;
    } else if (type == kVTBallotTypeSelectTwo) {
        VTSelectTwoBallot *selectOneBallot = [[VTSelectTwoBallot alloc] init];
        ballot = selectOneBallot;
    } else if (type == kVTBallotTypeRankedChoice) {
        VTRankedChoiceBallot *selectOneBallot = [[VTRankedChoiceBallot alloc] init];
        ballot = selectOneBallot;
    } else {
        // We couldn't match a ballot type to a class, so return nil for now
        return nil;
    }
    
    // After creation is verified, ensure the required ballot properties are stored
    ballot.title = title;
    ballot.options = options;
    
    // If any optional fields have been provided, set them here, otherwise, leave them nil
    if (subtitle) {
        ballot.subtitle = subtitle;
    }
    if (instructions) {
        ballot.instructions = instructions;
    }
    if (ballotNote) {
        ballot.ballotNote = ballotNote;
    }
    
    return ballot;

}

@end
