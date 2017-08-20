//
//  NSDate+VTDateUtils.h
//  Votem Example
//
//  Created by Matt on 8/18/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (VTDateUtils)
/**
 Returns an ISO 8601 formatted date string (yyyy-MM-dd'T'HH:mm:ss.SSS)
 */
- (NSString *)vt_dateAsISO8601String;

/**
 Returns a day-month-year formatted date string
 */
- (NSString *)vt_dateAsDayMonthYearString;

/** 
 Returns a day-month-year formatted date string, with AM/PM time
 */
- (NSString *)vt_dateAsDayMonthYearTimeString;
@end
