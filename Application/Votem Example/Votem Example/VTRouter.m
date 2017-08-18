//
//  VTRouter.m
//  Votem Example
//
//  Created by Matt on 8/13/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import "VTRouter.h"
#import "VTSignInViewController.h"
#import "VTCoordinatorTableViewController.h"
#import "VTContestsViewCoordinator.h"
#import "VTContestsTableViewController.h"

@implementation VTRouter

+ (void)routeToSignIn {
    // Create a new window and navigation controller
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UIViewController *viewController = [[VTSignInViewController alloc] initWithNibName:@"VTSignInViewController" bundle:nil];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    // Show the window and set it's root view controller
    [window makeKeyAndVisible];
    [window setRootViewController:navigationController];
    
    // Set the application's window to the new window
    [[UIApplication sharedApplication].delegate setWindow:window];
}

+ (void)presentViewControllerModally:(UIViewController*)viewController {
    [[UINavigationBar appearance] setTintColor:[UIColor vt_highlightBrandColor]];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    UIBarButtonItem *closeModalItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:[VTRouter class] action:@selector(dismissModalViewController)];
    
    [viewController.navigationItem setRightBarButtonItem:closeModalItem];
    [[VTRouter navigationController] presentViewController:navigationController animated:YES completion:nil];
}

+ (void)routeSignInSuccess {
    VTContestsViewCoordinator *coordinator = [[VTContestsViewCoordinator alloc] init];
    VTContestsTableViewController *vc = [[VTContestsTableViewController alloc] initWithCoordinator:coordinator];
    
//    UINavigationController *newNavigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    UINavigationController *rootNavigationController = [VTRouter navigationController];
    [rootNavigationController pushViewController:vc animated:YES];
}

+ (void)pushViewController:(UIViewController *)viewController {
    [[VTRouter navigationController] pushViewController:viewController animated:YES];
}

+ (UINavigationController *)navigationController {
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    UINavigationController *navigationController = (UINavigationController*) window.rootViewController;
    return navigationController;
}

+ (UIViewController *)rootViewController {
    // Retreive the root view controller from the main window
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    UIViewController *controller = window.rootViewController;
    if ([controller isKindOfClass:UINavigationController.class]) {
        // If the controller at the root of the window is a navigation controller, get the top-most view controller on the stack
        __weak UINavigationController *navigationController = (UINavigationController*)controller;
        return [navigationController topViewController];
    } else {
        // Otherwise return the root view controller
        return controller;
    }
}

/**
 Dismisses an active modal view controller
 */
+ (void)dismissModalViewController {
    [[VTRouter rootViewController] dismissViewControllerAnimated:YES completion:nil];
}


@end
