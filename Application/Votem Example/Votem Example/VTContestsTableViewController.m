//
//  VTContestsTableViewController.m
//  Votem Example
//
//  Created by Matt on 8/16/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import "VTContestsTableViewController.h"
#import "VTBallotListTableViewController.h"
#import "VTBallotTableViewCoordinator.h"
#import "VTTableViewCell.h"
#import "VTContest.h"
#import "VTRouter.h"
#import "NSDate+VTDateUtils.h"

@interface VTContestsTableViewController ()

@end

@implementation VTContestsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VTContest *objectForRow = (VTContest*)[self objectForRowAtIndexPath:indexPath];
    NSString *placeholderString = [NSString stringWithFormat:@"%@ - %zd ballot(s)", objectForRow.name, objectForRow.availableBallots.count];
    
    VTTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[VTTableViewCell vt_reuseIdentifier] forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.contentTextLabel.text = placeholderString;
    if (!objectForRow.completed) {
        cell.contentDetailTextLabel.text = [NSString stringWithFormat:NSLocalizedString(@"CONTESTS.CONTEST_END_DATE", @"Contest ends at string"), [objectForRow.endDate vt_dateAsDayMonthYearString]];
    } else {
        cell.contentDetailTextLabel.text = @"Completed";
    }
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    VTContest *objectForRow = (VTContest*)[self objectForRowAtIndexPath:indexPath];
    // If the contest has been completed, don't allow the user to reenter
    if (!objectForRow.completed) {
        return YES;
    }
    return NO;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    VTContest *objectForRow = (VTContest*)[self objectForRowAtIndexPath:indexPath];
    // If the contest has been completed, don't allow the user to reenter
    if (objectForRow.completed) {
        return;
    }
    
    VTBallotTableViewCoordinator *coordinator = [[VTBallotTableViewCoordinator alloc] initWithContest:objectForRow];
    VTBallotListTableViewController *vc = [[VTBallotListTableViewController alloc] initWithCoordinator:coordinator];
    vc.contest = objectForRow;
    [VTRouter pushViewController:vc];
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
