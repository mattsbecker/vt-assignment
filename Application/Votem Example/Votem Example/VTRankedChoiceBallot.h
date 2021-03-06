//
//  VTRankedChoiceBallot.h
//  Votem Example
//
//  Created by Matt on 8/16/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VTBallot.h"

@interface VTRankedChoiceBallot : VTBallot

@property(nonatomic, strong) NSString *instructions;
@property(nonatomic, strong) NSString *subtitle;
@property(nonatomic, strong) NSString *ballotNote;

@end
