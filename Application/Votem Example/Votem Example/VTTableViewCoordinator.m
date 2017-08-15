//
//  VTTableViewCoordinator.m
//  Votem Example
//
//  Created by Matt on 8/14/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import "VTTableViewCoordinator.h"

@interface VTTableViewCoordinator()

@property (nonatomic, strong) NSMutableArray *mutableLoadedData;

@end

@implementation VTTableViewCoordinator
@synthesize isLoading = _isLoading;
@synthesize loadedData = _loadedData;

- (void)setLoadedData:(NSArray *)loadedData {
    _loadedData = loadedData;
}

- (void)setIsLoading:(BOOL)isLoading {
    _isLoading = isLoading;
}

- (void)fetchData {
    self.mutableLoadedData = [NSMutableArray arrayWithObjects:@"First Cell", @"Second Cell", @"Third Cell", nil];
    self.loadedData = [NSArray arrayWithArray:self.mutableLoadedData];
    [self notifiyDelegateDataLoaded:self.loadedData];
}

- (void)notifiyDelegateDataLoaded:(NSArray*)data {
    if ([self.delegate respondsToSelector:@selector(tableViewCoordinator:loadedData:)]) {
        [self.delegate tableViewCoordinator:self loadedData:self.loadedData];
    }
}

- (void)notifyDelegateEncounteredError:(NSError*)error {
    if ([self.delegate respondsToSelector:@selector(tableViewCoordinator:encounteredError:)]) {
        [self.delegate tableViewCoordinator:self encounteredError:error];
    }
}

@end
