//
//  VTRouter.h
//  Votem Example
//
//  Created by Matt on 8/13/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface VTRouter : NSObject

/**
Create the application root navigation controller and initial contest view controller
 */
+ (void)createApplicationRoot;

/**
 Presents the sign in view controller in a root navigation controller
 */
+ (void)routeToSignIn;
/**
 Presents a new view controller modally. The provided view controller will be inserted into a navigation controller for convenience.
 @parameter viewController A UIViewController that should be presented modally
 */
+ (void)presentViewControllerModally:(UIViewController*)viewController;

/**
 Pushes a new view controller onto the existing navigation controller stack
 @parameter viewController A UIViewController that should be presented modally
 */
+ (void)pushViewController:(UIViewController *)viewController;

/**
 Returns the current navigation controller
 */
+ (UINavigationController *)navigationController;

/**
 Returns the currently visible root view controller
 */
+ (UIViewController *)rootViewController;

/**
 Routes the user to the application after a successful sign in
 */
+ (void)routeSignInSuccess;

@end
