//
//  VTCreateAccountTableViewCoordinator.m
//  Votem Example
//
//  Created by Matt on 8/14/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import "VTCreateAccountTableViewCoordinator.h"
#import <UIKit/UIKit.h>

@interface VTCreateAccountTableViewCoordinator()

@property (nonatomic, strong) NSMutableDictionary *mutableRegistrationData;

@end

@implementation VTCreateAccountTableViewCoordinator
@synthesize loadedData = _loadedData;
@synthesize isLoading = _isLoading;

- (void)fetchData {
    self.mutableRegistrationData = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"", @(VTRegistrationEmailKey), @"", @(VTRegistrationPasswordKey), @"", @(VTRegistrationConfirmPasswordKey), nil];
    self.loadedData = @[self.mutableRegistrationData];
    [self notifiyDelegateDataLoaded:self.loadedData];
}

- (void)setLoadedData:(NSArray *)loadedData {
    _loadedData = loadedData;
}

- (void)setIsLoading:(BOOL)isLoading {
    _isLoading = isLoading;
}

- (NSString *)dictionaryKeyForValue:(NSNumber*)value {
    switch(value.unsignedIntegerValue) {
        case VTRegistrationEmailKey:
            return @"emailAddress";
            break;
        case VTRegistrationPasswordKey:
            return @"password";
            break;
        case VTRegistrationConfirmPasswordKey:
            return @"passwordConfirm";
            break;
        default:
            return @"";
            break;
    }
}

- (NSString *)displayStringForValue:(NSNumber*)value {
    switch (value.unsignedIntegerValue) {
        case VTRegistrationEmailKey:
            return NSLocalizedString(@"ONBOARDING.CREATE_ACCOUNT_EMAIL_FIELD_PLACEHOLDER", @"Email placeholder string");
            break;
        case VTRegistrationPasswordKey:
            return NSLocalizedString(@"ONBOARDING.CREATE_ACCOUNT_PASSWORD_PLACEHOLDER", @"Password placeholder string");
            break;
        case VTRegistrationConfirmPasswordKey:
            return NSLocalizedString(@"ONBOARDING.CREATE_ACCOUNT_CONFIRM_PASSWORD_PLACEHOLDER", @"Confirm Password placeholder string");
        default:
            return @"";
            break;
    }
}

- (NSDictionary*)keyboardTypeForValue:(NSNumber*)value {
    switch(value.unsignedIntegerValue) {
        case VTRegistrationEmailKey:
            return @{kVTKeyboardTypeValueKeyboardTypeKey: @(UIKeyboardTypeEmailAddress), kVTKeyboardTypeValueSecureEntryKey : @(NO)};
            break;
        case VTRegistrationPasswordKey:
            return @{kVTKeyboardTypeValueKeyboardTypeKey: @(UIKeyboardTypeDefault), kVTKeyboardTypeValueSecureEntryKey : @(YES)};
            break;
        case VTRegistrationConfirmPasswordKey:
            return @{kVTKeyboardTypeValueKeyboardTypeKey: @(UIKeyboardTypeDefault), kVTKeyboardTypeValueSecureEntryKey : @(YES)};
            break;
        default:
            return @{kVTKeyboardTypeValueKeyboardTypeKey: @(UIKeyboardTypeDefault), kVTKeyboardTypeValueSecureEntryKey : @(NO)};
            break;
    }
}

@end
