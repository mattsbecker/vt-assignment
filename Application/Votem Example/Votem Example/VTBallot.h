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
@property(nonatomic, strong) NSArray<VTBallotOption *> *options;
@property(nonatomic, strong) NSArray<VTBallotOption *> *selections;
@property(nonatomic, assign) VTBallotType type;
@property(nonatomic, assign) BOOL enabled;
@property(nonatomic, assign) NSInteger allowedNumberOfSelections;
@property(nonatomic, assign) BOOL allowsWriteIn;

@optional
@property(nonatomic, strong) NSString *subtitle;
@property(nonatomic, strong) NSString *instructions;
@property(nonatomic, strong) NSString *ballotNote;

@end


@interface VTBallot : NSObject<VTBallot>

@property(nonatomic, assign) NSNumber *ballotId;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSArray<VTBallotOption *> *options;
@property(nonatomic, strong) NSArray<VTBallotOption *> *selections;
@property(nonatomic, assign) VTBallotType type;
@property(nonatomic, assign) BOOL enabled;
@property(nonatomic, assign) NSInteger allowedNumberOfSelections;
@property(nonatomic, readonly) NSArray<NSObject*> *keyValueObservers;
@property(nonatomic, assign) BOOL submittable;
@property(nonatomic, assign) BOOL allowsWriteIn;

- (void)selectOption:(VTBallotOption *)option;
- (void)deselectOption:(VTBallotOption *)option;
- (void)addKeyValueObserver:(NSObject*)keyValueObserver;
- (void)removeKeyValueObserver:(NSObject*)keyValueObserver;
- (void)moveSelection:option fromPosition:(NSInteger)fromPostition toPosition:(NSInteger)toPosition;
- (void)prepareForWriteInAdditionWithText:(NSString *)text;
- (void)removeWriteInSelection:(VTBallotOption*)option;
- (BOOL)evaluateSubmittable;

@end
