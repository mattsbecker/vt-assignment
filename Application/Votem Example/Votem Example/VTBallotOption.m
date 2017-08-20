//
//  VTBallotOption.m
//  Votem Example
//
//  Created by Matt on 8/18/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import "VTBallotOption.h"

@implementation VTBallotOption

- (void)updateText:(NSString *)text {
    // No editing is allowed unless this ballot option is a write-in
    if (!self.writeIn) {
        return;
    }
    self.title = text;
}
@end
