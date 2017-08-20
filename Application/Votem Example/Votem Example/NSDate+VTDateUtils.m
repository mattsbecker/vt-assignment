//
//  NSDate+VTDateUtils.m
//  Votem Example
//
//  Created by Matt on 8/18/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import "NSDate+VTDateUtils.h"

@implementation NSDate (VTDateUtils)

- (NSString *)vt_dateAsISO8601String {
    NSString *formatted = [self _dateStringWithFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];
    return formatted;
}

- (NSString *)vt_dateAsDayMonthYearString {
    NSString *formatted = [self _dateStringWithFormat:@"dd-MM-yyyy"];
    return formatted;
}

- (NSString *)vt_dateAsDayMonthYearTimeString {
    NSString *formatted = [self _dateStringWithFormat:@"dd-MM-yyyy h:mm a"];
    return formatted;
}

- (NSString *)_dateStringWithFormat:(NSString *)format {
    NSString *formatted;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    formatted = [formatter stringFromDate:self];
    return formatted;
}

@end
