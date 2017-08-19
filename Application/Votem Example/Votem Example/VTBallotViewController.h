//
//  VTBallotViewController.h
//  Votem Example
//
//  Created by Matt on 8/18/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VTContest.h"

@interface VTBallotViewController : UIViewController
@property (nonatomic, assign) VTBallot *ballot;
@property (nonatomic, assign) VTContest *contest;
@end
