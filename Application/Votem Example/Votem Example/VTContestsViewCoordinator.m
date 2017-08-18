//
//  VTContestsViewCoordinator.m
//  Votem Example
//
//  Created by Matt on 8/16/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import "VTContestsViewCoordinator.h"
#import "VTRankedChoiceBallot.h"
#import "VTSelectOneBallot.h"
#import "VTSelectTwoBallot.h"
#import "VTBallotFactory.h"
#import <UIKit/UIKit.h>

@interface VTContestsViewCoordinator()
@property(nonatomic, strong) NSMutableArray *mutableContests;
@end

@implementation VTContestsViewCoordinator
@synthesize loadedData = _loadedData;
@synthesize isLoading = _isLoading;

-(instancetype)init {
    self = [super init];
    return self;
}

- (void)fetchData {
    self.isLoading = YES;
    VTContest *contest = [[VTContest alloc] init];
    contest.name = @"General Election 2020";
    VTSelectOneBallot *selectOneWithNoteBallot = (VTSelectOneBallot*)[VTBallotFactory ballotWithType:kVTBallotTypeSelectOne title:@"Ballot Issue" subTitle:@"Constiutional Initiative No. 116" instructions:@"Vote by selecting one checkbox" ballotNote:@"Make Vanilla (Over Chocolate) the official best flavor. \nThis is a fiercely debated topic and CI - 116 would offically enumerate in writted legislative text in perpetuity which flavor has favor – namely vanilla is better, unequivocally, then chocolate." options:[self chooseOneWithNoteBallotOptions]];

    VTSelectOneBallot *selectOneBallot = (VTSelectOneBallot*)[VTBallotFactory ballotWithType:kVTBallotTypeSelectOne title:@"For Cheif Dairy Queen" subTitle:@"Shall Justice Mint C. Chip of the Supreme Court of the State of Ice Create be retained in office for another term?" instructions:@"Select the checkbox before the word \"YES\" if you wish the official to remain in office. \nSelect the checkbox before the word \"NO\" if you do not wish the official to remain in office" ballotNote:nil options:[self chooseOneBallotOptions]];

    contest.availableBallots = @[selectOneBallot, selectOneWithNoteBallot];
    
    self.mutableContests = [NSMutableArray arrayWithObject:contest];
    
    self.loadedData = [NSArray arrayWithArray:self.mutableContests];
    self.isLoading = NO;
    [self notifiyDelegateDataLoaded:self.loadedData];
}

- (void)setLoadedData:(NSArray *)loadedData {
    _loadedData = loadedData;
}

- (void)setIsLoading:(BOOL)isLoading {
    _isLoading = isLoading;
}

- (NSArray *)chooseOneWithNoteBallotOptions {
    VTBallotOption *option1 = [[VTBallotOption alloc] init];
    option1.title = @"YES ON CI - 116 (FOR VANILLA)";
    
    VTBallotOption *option2 = [[VTBallotOption alloc] init];
    option2.title = @"NO ON 116 (NO ON VANILLA)";
    
    NSArray *chooseOneOptions = [NSArray arrayWithObjects:option1, option2, nil];
    return chooseOneOptions;
}

- (NSArray *)chooseOneBallotOptions {
    VTBallotOption *option1 = [[VTBallotOption alloc] init];
    option1.title = @"YES";
    
    VTBallotOption *option2 = [[VTBallotOption alloc] init];
    option2.title = @"NO";
    
    NSArray *chooseOneOptions = [NSArray arrayWithObjects:option1, option2, nil];
    return chooseOneOptions;
}



@end
