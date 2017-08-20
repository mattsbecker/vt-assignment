//
//  VTCoordinatorTableViewController.m
//  Votem Example
//
//  Created by Matt on 8/14/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import "VTCoordinatorTableViewController.h"

@interface VTCoordinatorTableViewController ()

@end

@implementation VTCoordinatorTableViewController

- (instancetype)initWithCoordinator:(VTTableViewCoordinator*)coordinator {
    self = [[[self class] alloc] initWithNibName:[[self class] nibNamed] bundle:nil];
    self.coordinator = coordinator;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [[self class] registerTableViewCells:self.tableView];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.coordinator fetchData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    self.title = [[self class] titleForViewController];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.coordinator.loadedData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id objectForSection = [self objectForSection:section];
    if ([objectForSection isKindOfClass:NSArray.class]) {
        __weak NSArray *objectArray = (NSArray *)objectForSection;
        return objectArray.count;
    } else if ([objectForSection isKindOfClass:NSDictionary.class]) {
        __weak NSDictionary *objectDictionary = (NSDictionary *)objectForSection;
        return objectDictionary.allKeys.count;
    } else {
        return 1;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VTTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[VTTableViewCell vt_reuseIdentifier] forIndexPath:indexPath];
    return cell;
}

- (void)tableViewCoordinator:(VTTableViewCoordinator*)coordinator loadedData:(NSArray*)data {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)tableViewCoordinator:(VTTableViewCoordinator *)coordinator encounteredError:(NSError *)error {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

# pragma mark --- Private Methods ---

- (id)objectForSection:(NSInteger)section {
    id object = self.coordinator.loadedData[section];
    return object;
}

- (id)objectForRowAtIndexPath:(NSIndexPath *)indexPath {
    id objectForSection = [self objectForSection:indexPath.section];
    if ([objectForSection isKindOfClass:NSArray.class]) {
        return objectForSection[indexPath.row];
    } else if ([objectForSection isKindOfClass:NSDictionary.class]) {
        __weak NSDictionary *dictionary = (NSDictionary *)objectForSection;
        NSArray *keys = dictionary.allKeys;
        return keys[indexPath.row];
    } else {
        return objectForSection;
    }
}

# pragma mark --- Class Methods for Overriding ---
+ (NSString *)titleForViewController {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"%@ must be overridden by a subclass", NSStringFromSelector(_cmd)] userInfo:nil];
}

+ (NSString *)nibNamed {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"%@ must be overridden by a subclass", NSStringFromSelector(_cmd)] userInfo:nil];
}

+ (void)registerTableViewCells:(UITableView*)tableView {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"%@ must be overridden by a subclass", NSStringFromSelector(_cmd)] userInfo:nil];
}

@end
