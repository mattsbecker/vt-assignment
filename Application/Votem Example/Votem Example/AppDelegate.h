//
//  AppDelegate.h
//  Votem Example
//
//  Created by Matt on 8/12/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

