//
//  VTBallotOption.h
//  Votem Example
//
//  Created by Matt on 8/18/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VTBallotOption : NSObject
@property (nonatomic, assign) NSNumber *optionId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL writeIn;

- (void)updateText:(NSString *)text;

@end
