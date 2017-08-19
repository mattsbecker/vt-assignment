//
//  VTBallotController.h
//  Votem Example
//
//  Created by Matt on 8/19/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VTBallot.h"

@interface VTBallotController : NSObject

- (instancetype)initWithBallot:(VTBallot*)ballot;

/**
 Applies a user's choice for a provided ballot and provides an array containing the user's current selections.
 */

- (NSArray<VTBallotOption*>*)applySelection:(VTBallotOption*)ballotOption;

@end
