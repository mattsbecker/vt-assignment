//
//  VTBallotListTableViewController.m
//  Votem Example
//
//  Created by Matt on 8/18/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import "VTBallotListTableViewController.h"
#import "VTBallotViewController.h"
#import "VTRouter.h"
#import <Masonry/Masonry.h>

@interface VTBallotListTableViewController ()

@end

@implementation VTBallotListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VTBallot *objectForRow = (VTBallot *)[self objectForRowAtIndexPath:indexPath];
    NSString *placeholderString = [NSString stringWithFormat:@"%@ - %@ ballot(s)", objectForRow.title, @(objectForRow.type)];
    
    VTTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[VTTableViewCell vt_reuseIdentifier]];
    cell.tintColor = [UIColor vt_highlightBrandColor];
    cell.contentTextLabel.numberOfLines = 0;
    cell.contentTextLabel.text = placeholderString;
    cell.contentDetailTextLabel.text = objectForRow.instructions;
    cell.contentDetailTextLabel.numberOfLines = 0;
    
    if (objectForRow.selections.count > 0) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    VTBallot *objectForRow = (VTBallot *)[self objectForRowAtIndexPath:indexPath];
    VTBallotViewController *vc = [[VTBallotViewController alloc] initWithNibName:@"VTBallotViewController" bundle:nil];
    vc.contest = self.contest;
    
    [VTRouter presentViewControllerModally:vc];
    vc.ballot = objectForRow;

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
