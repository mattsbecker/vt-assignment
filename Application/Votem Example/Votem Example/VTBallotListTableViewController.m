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
    VTTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[VTTableViewCell vt_reuseIdentifier]];
    if (indexPath.section == 1) {
        [self.contest evaluateContestCompletionStatus];
        if ([[self objectForRowAtIndexPath:indexPath] isEqual:kVTContestSubmitRow]) {
            cell.contentTextLabel.text = @"Submit";
            cell.contentTextLabel.font = [UIFont vt_standardContentFont];
            cell.contentTextLabel.textColor = self.contest.completed ? [UIColor vt_highlightBrandColor] : [UIColor lightGrayColor];
            cell.contentDetailTextLabel.text = @"";
            return cell;
        }
    }

    VTBallot *objectForRow = (VTBallot *)[self objectForRowAtIndexPath:indexPath];
    NSString *placeholderString = [NSString stringWithFormat:@"%@", objectForRow.title];
    
    cell.tintColor = [UIColor vt_highlightBrandColor];
    cell.contentTextLabel.numberOfLines = 0;
    cell.contentTextLabel.text = placeholderString;
    cell.contentDetailTextLabel.text = @"";
    cell.contentDetailTextLabel.numberOfLines = 0;
    
    if (objectForRow.selections.count > 0) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        [self.contest evaluateContestCompletionStatus];
        if (!self.contest.completed) {
            return;
        } else {
            UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Your selections have been submitted!" message:@"Your selections have been submitted. Thank you for participating in this contest." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [controller addAction:action];
            [self.navigationController presentViewController:controller animated:YES completion:nil];
            return;
        }
    }
    VTBallot *objectForRow = (VTBallot *)[self objectForRowAtIndexPath:indexPath];
    VTBallotViewController *vc = [[VTBallotViewController alloc] initWithNibName:@"VTBallotViewController" bundle:nil];
    vc.contest = self.contest;
    
    [VTRouter presentViewControllerModally:vc];
    vc.ballot = objectForRow;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0;
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
