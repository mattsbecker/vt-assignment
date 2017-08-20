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
    contest.name = @"Federal and State Election";

    VTRankedChoiceBallot *rankChoiceBallot = (VTRankedChoiceBallot*)[VTBallotFactory ballotWithType:kVTBallotTypeRankedChoice title:@"For Fommander In Cream and Vice Ice" subTitle:@"Ranked Choice Voting (Instant Runoff)" instructions:@"Rank candidates in order of choice. Mark your favorite candidate as first choice, and then indicate your second and additional back-up choices in order of choice. You may rank as many candidates as you want." ballotNote:nil options:[self rankedChoiceBallotOptions] allowsWriteIn:YES];
    // Ranked choice allows ballot write-ins

    VTSelectOneBallot *selectOneBallot = (VTSelectOneBallot*)[VTBallotFactory ballotWithType:kVTBallotTypeSelectOne title:@"For Cheif Dairy Queen" subTitle:@"Shall Justice Mint C. Chip of the Supreme Court of the State of Ice Create be retained in office for another term?" instructions:@"Select the checkbox before the word \"YES\" if you wish the official to remain in office. \nSelect the checkbox before the word \"NO\" if you do not wish the official to remain in office" ballotNote:nil options:[self chooseOneBallotOptions] allowsWriteIn:NO];

    VTSelectTwoBallot *selectTwoBallot = (VTSelectTwoBallot*)[VTBallotFactory ballotWithType:kVTBallotTypeSelectTwo title:@"For State Rep. District M&M" subTitle:nil instructions:@"Vote for two" ballotNote:nil options:[self chooseTwoBallotOptions] allowsWriteIn:NO];

    
    contest.contestId = @(100);
    contest.startDate = [NSDate date];
    contest.endDate = [NSDate dateWithTimeIntervalSinceNow:1440];
    contest.enabled = YES;
    contest.availableBallots = @[rankChoiceBallot, selectOneBallot, selectTwoBallot];
    
    VTContest *countyElection = [[VTContest alloc] init];
    countyElection.name = @"County Election";

    VTSelectOneBallot *selectOneWithNoteBallot = (VTSelectOneBallot*)[VTBallotFactory ballotWithType:kVTBallotTypeSelectOne title:@"Ballot Issue" subTitle:@"Constiutional Initiative No. 116" instructions:@"Vote by selecting one checkbox" ballotNote:@"Make Vanilla (Over Chocolate) the official best flavor. \nThis is a fiercely debated topic and CI - 116 would offically enumerate in writted legislative text in perpetuity which flavor has favor – namely vanilla is better, unequivocally, then chocolate." options:[self chooseOneWithNoteBallotOptions] allowsWriteIn:NO];
    countyElection.contestId = @(100);
    countyElection.startDate = [NSDate date];
    countyElection.endDate = [NSDate dateWithTimeIntervalSinceNow:1440];
    countyElection.enabled = YES;
    countyElection.availableBallots = @[selectOneWithNoteBallot];
    
    self.mutableContests = [NSMutableArray arrayWithObjects:contest, countyElection, nil];
    
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

- (NSArray *)chooseTwoBallotOptions {
    VTBallotOption *option1 = [[VTBallotOption alloc] init];
    option1.optionId = @100;
    option1.title = @"P. Nut Butter (REPUBLICAN)";
    
    VTBallotOption *option2 = [[VTBallotOption alloc] init];
    option1.optionId = @102;
    option2.title = @"Cream C. Kol (INDEPENDENT)";
    
    VTBallotOption *option3 = [[VTBallotOption alloc] init];
    option1.optionId = @102;
    option3.title = @"Marsh Mallow (DEMOCRAT)";
    
    NSArray *chooseTwoOptions = [NSArray arrayWithObjects:option1, option2, option3, nil];
    return chooseTwoOptions;
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

- (NSArray *)rankedChoiceBallotOptions {
    VTBallotOption *option1 = [[VTBallotOption alloc] init];
    option1.title = @"Reese WithoutASpoon - Democrat for C.I.C \nCherry Garcia - Democrat for Vice Ice";
    
    VTBallotOption *option2 = [[VTBallotOption alloc] init];
    option2.title = @"Choco 'Chip' Dough - Republican for C.I.C \nCarmela Coney - Republican for Vice Ice";
    
    VTBallotOption *option3 = [[VTBallotOption alloc] init];
    option3.title = @"Magic Browny - Independent for C.I.C \nPhish Food - Independent for Vice Ice";
    
    NSArray *rankedChoiceOptions = [NSArray arrayWithObjects:option1, option2, option3, nil];
    
    return rankedChoiceOptions;
}

@end
