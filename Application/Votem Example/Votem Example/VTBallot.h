//
//  VTBallot.h
//  Votem Example
//
//  Created by Matt on 8/16/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, VTBallotType) {
    kVTBallotTypeRankedChoice,
    kVTBallotTypeSelectOne,
    kVTBallotTypeSelectTwo
};

@class VTBallot;

@protocol VTBallot <NSObject>

@required

@property(nonatomic, assign) NSInteger ballotId;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSArray *options;
@property(nonatomic, strong) NSArray *selections;
@property(nonatomic, assign) VTBallotType type;
@property(nonatomic, assign) BOOL enabled;

@optional
@property(nonatomic, strong) NSString *instructions;

@end


@interface VTBallot : NSObject<VTBallot>

@property(nonatomic, assign) NSInteger ballotId;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSArray *options;
@property(nonatomic, strong) NSArray *selections;
@property(nonatomic, assign) VTBallotType type;
@property(nonatomic, assign) BOOL enabled;

@end
