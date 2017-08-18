//
//  VTBallotFactory.h
//  Votem Example
//
//  Created by Matt on 8/18/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VTBallot.h"

@interface VTBallotFactory : NSObject

+ (VTBallot *)ballotWithType:(VTBallotType)type
                       title:(NSString *)title
                    subTitle:(NSString *)subtitle
                instructions:(NSString *)instructions
                  ballotNote:(NSString *)ballotNote
                     options:(NSArray *)options;
@end
