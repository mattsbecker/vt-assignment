//
//  VTContestsTableViewController.m
//  Votem Example
//
//  Created by Matt on 8/16/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import "VTContestsTableViewController.h"
#import "VTTableViewCell.h"
#import "VTContest.h"
@interface VTContestsTableViewController ()

@end

@implementation VTContestsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VTContest *objectForRow = (VTContest*)[self objectForSection:indexPath.section];
    NSString *placeholderString = [NSString stringWithFormat:@"%@ - %zd ballot(s)", objectForRow.name, objectForRow.availableBallots.count];
    
    VTTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[VTTableViewCell vt_reuseIdentifier] forIndexPath:indexPath];
    //NSString *placeholderString = [self.coordinator registrationKeyForValue:(NSUInteger)[super objectForRowAtIndexPath:indexPath]];
    cell.textLabel.text = placeholderString;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 52.0;
}

+ (void)registerTableViewCells:(UITableView*)tableView {
    [tableView registerNib:[VTTableViewCell vt_tableViewCellNib] forCellReuseIdentifier:[VTTableViewCell vt_reuseIdentifier]];
}

+ (NSString *)nibNamed {
    return @"VTContestsTableViewController";
}

+ (NSString *)titleForViewController {
    return NSLocalizedString(@"CONTESTS.SELECT_CONTEST_TITLE", @"Select contest title");
}


@end
