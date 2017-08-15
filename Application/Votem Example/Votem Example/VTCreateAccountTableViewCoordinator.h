//
//  VTSignInTableViewCoordinator.h
//  Votem Example
//
//  Created by Matt on 8/14/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import "VTTableViewCoordinator.h"

typedef NS_ENUM(NSUInteger, VTRegistrationKeys) {
    VTRegistrationEmailKey,
    VTRegistrationPasswordKey,
    VTRegistrationConfirmPasswordKey,
    VTRegistrationKeysCount
};

@interface VTCreateAccountTableViewCoordinator : VTTableViewCoordinator

@end
