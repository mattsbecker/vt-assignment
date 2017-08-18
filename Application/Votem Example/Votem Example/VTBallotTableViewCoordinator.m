//
//  VTBallotTableViewCoordinator.m
//  Votem Example
//
//  Created by Matt on 8/18/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import "VTBallotTableViewCoordinator.h"

@interface VTBallotTableViewCoordinator()
@property(nonatomic, strong) VTContest *contest;
@end

@implementation VTBallotTableViewCoordinator
@synthesize loadedData = _loadedData;
@synthesize isLoading = _isLoading;
-(instancetype)initWithContest:(VTContest *)contest {
    self = [super init];
    self.contest = contest;
    return self;
}

- (void)fetchData {
    self.isLoading = YES;
    self.loadedData = @[[NSArray arrayWithArray:self.contest.availableBallots]];
    self.isLoading = NO;
    [self notifiyDelegateDataLoaded:self.loadedData];
}

- (void)setLoadedData:(NSArray *)loadedData {
    _loadedData = loadedData;
}

- (void)setIsLoading:(BOOL)isLoading {
    _isLoading = isLoading;
}

@end
