//
//  VTBaseViewController.m
//  Votem Example
//
//  Created by Matt on 8/13/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import "VTBaseViewController.h"

@interface VTBaseViewController ()

@end

@implementation VTBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    self.title = [[self class] titleForViewController];
}

#pragma mark --- Class methods for Overriding ---

+ (NSString *)titleForViewController {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"%@ must be overridden by a subclass", NSStringFromSelector(_cmd)] userInfo:nil];
}


@end
