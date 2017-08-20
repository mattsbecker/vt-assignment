//
//  VTCreateAccountViewController.m
//  Votem Example
//
//  Created by Matt on 8/14/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import "VTCreateAccountViewController.h"
#import "VTTextEntryTableViewCell.h"

@interface VTCreateAccountViewController ()

@end

@implementation VTCreateAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *objectForRow = (NSDictionary*)[self objectForSection:indexPath.section];
    NSArray *keys = objectForRow.allKeys;
    NSNumber *key = (NSNumber*)keys[indexPath.row];
    NSString *placeholderString = [self.coordinator displayStringForValue:key];

    VTTextEntryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[VTTextEntryTableViewCell vt_reuseIdentifier] forIndexPath:indexPath];
    cell.textField.placeholder = placeholderString;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 52.0;
}

+ (void)registerTableViewCells:(UITableView*)tableView {
    [tableView registerNib:[VTTextEntryTableViewCell vt_tableViewCellNib] forCellReuseIdentifier:[VTTextEntryTableViewCell vt_reuseIdentifier]];
}

+ (NSString *)nibNamed {
    return @"VTCreateAccountViewController";
}

+ (NSString *)titleForViewController {
    return NSLocalizedString(@"ONBOARDING.CREATE_ACCOUNT_TITLE", @"Create account title");
}

@end
