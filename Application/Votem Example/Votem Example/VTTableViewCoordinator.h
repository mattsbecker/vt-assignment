//
//  VTTableViewCoordinator.h
//  Votem Example
//
//  Created by Matt on 8/14/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString const *kVTKeyboardTypeValueKeyboardTypeKey;
extern NSString const *kVTKeyboardTypeValueSecureEntryKey;
extern NSString const *kVTContestSubmitRow;

@class VTTableViewCoordinator;

@protocol VTTableViewCoordinatorDelegate <NSObject>

- (void)tableViewCoordinator:(VTTableViewCoordinator*)coordinator loadedData:(NSArray*)data;
- (void)tableViewCoordinator:(VTTableViewCoordinator *)coordinator encounteredError:(NSError *)error;

@end

@interface VTTableViewCoordinator : NSObject

@property (nonatomic, readonly) NSArray *loadedData;
@property (nonatomic, readonly) BOOL isLoading;
@property (nonatomic, assign) id<VTTableViewCoordinatorDelegate> delegate;

- (void)notifiyDelegateDataLoaded:(NSArray*)data;
- (void)notifyDelegateEncounteredError:(NSError*)error;
- (void)fetchData;

- (NSString *)dictionaryKeyForValue:(NSNumber*)value;
- (NSString *)displayStringForValue:(NSNumber*)value;
- (NSDictionary*)keyboardTypeForValue:(NSNumber*)value;

@end
