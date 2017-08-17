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
    VTContest *contest = [[VTContest alloc] init];
    contest.name = @"General Election 2020";
    VTRankedChoiceBallot *rankedChoice = [[VTRankedChoiceBallot alloc] init];
    rankedChoice.title = @"Ranked choice title";
    contest.availableBallots = @[rankedChoice];
    
    self.mutableContests = [NSMutableArray arrayWithObject:contest];
    
    self.loadedData = [NSArray arrayWithArray:self.mutableContests];
    [self notifiyDelegateDataLoaded:self.loadedData];
}

- (void)setLoadedData:(NSArray *)loadedData {
    _loadedData = loadedData;
}

- (void)setIsLoading:(BOOL)isLoading {
    _isLoading = isLoading;
}


@end
