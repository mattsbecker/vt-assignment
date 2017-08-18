//
//  VTBallotListTableViewController.m
//  Votem Example
//
//  Created by Matt on 8/18/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import "VTBallotListTableViewController.h"
#import "VTBallot.h"

@interface VTBallotListTableViewController ()

@end

@implementation VTBallotListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VTBallot *objectForRow = (VTBallot *)[self objectForRowAtIndexPath:indexPath];
    NSString *placeholderString = [NSString stringWithFormat:@"%@ - %@ ballot(s)", objectForRow.title, @(objectForRow.type)];
    
    VTTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[VTTableViewCell vt_reuseIdentifier]];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = placeholderString;
    cell.detailTextLabel.text = objectForRow.instructions;
    cell.detailTextLabel.numberOfLines = 0;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}

+ (void)registerTableViewCells:(UITableView*)tableView {
    [tableView registerNib:[VTTableViewCell vt_tableViewCellNib] forCellReuseIdentifier:[VTTableViewCell vt_reuseIdentifier]];
}

+ (NSString *)nibNamed {
    return @"VTBallotListTableViewController";
}

+ (NSString *)titleForViewController {
    return NSLocalizedString(@"CONTESTS.SELECT_CONTEST_TITLE", @"Select contest title");
}

@end
