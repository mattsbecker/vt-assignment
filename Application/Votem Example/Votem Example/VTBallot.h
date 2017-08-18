//
//  VTBallot.h
//  Votem Example
//
//  Created by Matt on 8/16/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VTBallotOption.h"

typedef NS_ENUM(NSUInteger, VTBallotType) {
    kVTBallotTypeRankedChoice,
    kVTBallotTypeSelectOne,
    kVTBallotTypeSelectTwo
};

extern NSString const *kVTBallotSelectionValueKey;

@class VTBallot;

@protocol VTBallot <NSObject>

@required

@property(nonatomic, assign) NSNumber *ballotId;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSArray *options;
@property(nonatomic, strong) NSArray<VTBallotOption *> *selections;
@property(nonatomic, assign) VTBallotType type;
@property(nonatomic, assign) BOOL enabled;

@optional
@property(nonatomic, strong) NSString *subtitle;
@property(nonatomic, strong) NSString *instructions;
@property(nonatomic, strong) NSString *ballotNote;

@end


@interface VTBallot : NSObject<VTBallot>

@property(nonatomic, assign) NSNumber *ballotId;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSArray *options;
@property(nonatomic, strong) NSArray<VTBallotOption *> *selections;
@property(nonatomic, assign) VTBallotType type;
@property(nonatomic, assign) BOOL enabled;
@property(nonatomic, readonly) NSArray<NSObject*> *keyValueObservers;

- (void)selectOption:(VTBallotOption *)option;
- (void)addKeyValueObserver:(NSObject*)keyValueObserver;
- (void)removeKeyValueObserver:(NSObject*)keyValueObserver;

@end
