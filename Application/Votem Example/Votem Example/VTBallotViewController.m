//
//  VTBallotViewController.m
//  Votem Example
//
//  Created by Matt on 8/18/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import "VTBallotViewController.h"
#import "UIFont+VTFonts.h"
#import "VTTableViewCell.h"

@interface VTBallotViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *ballotMeasureTableView;
@property (strong, nonatomic) IBOutlet UILabel *ballotMeasureTitle;
@property (strong, nonatomic) IBOutlet UILabel *ballotMeasureSubtitle;
@property (strong, nonatomic) IBOutlet UILabel *ballotMeasureNotesLabel;
@property (strong, nonatomic) IBOutlet UILabel *ballotMeasureInstructionsLabel;


@end

@implementation VTBallotViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.ballotMeasureTableView.delegate = self;
    self.ballotMeasureTableView.dataSource = self;
    [VTBallotViewController registerTableViewCells:self.ballotMeasureTableView];
    
    if (self.ballot != nil) {
        [self configureViewForBallot];
    }
    [self.ballotMeasureTableView reloadData];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.ballot.options.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (self.ballot.instructions) {
        return self.ballot.instructions.lowercaseString;
    } else {
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VTTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[VTTableViewCell vt_reuseIdentifier]];
    cell.tintColor = [UIColor vt_highlightBrandColor];
    cell.textLabel.text = self.ballot.options[indexPath.row].title;
    cell.detailTextLabel.text = @"";
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont vt_footnoteFont];
    
    
    // If this selection has been chosen by the user, mark it as such
    if ([self.ballot.selections containsObject:self.ballot.options[indexPath.row]]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    VTBallotOption *option = self.ballot.options[indexPath.row];
    if ([self.ballot.selections containsObject:option]) {
        [self.ballot deselectOption:option];
    } else {
        [self.ballot selectOption:option];
    }
    [self reloadTableViewSection:indexPath.section];
}

- (void) reloadTableViewSection:(NSInteger)section {
    [self.ballotMeasureTableView beginUpdates];
    [self.ballotMeasureTableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
    [self.ballotMeasureTableView endUpdates];
}

# pragma mark --- Instance Methods ---

# pragma mark --- Private Methods ---

+ (void)registerTableViewCells:(UITableView*)tableView {
    [tableView registerNib:[VTTableViewCell vt_tableViewCellNib] forCellReuseIdentifier:[VTTableViewCell vt_reuseIdentifier]];
}

- (void)configureViewForBallot {
    if (!self.ballot) {
        return;
    }
    self.ballotMeasureTitle.text = self.ballot.title != nil ? self.ballot.title : @"";
    self.ballotMeasureSubtitle.text = self.ballot.subtitle != nil ? self.ballot.subtitle : @"";
    self.ballotMeasureNotesLabel.text = self.ballot.ballotNote != nil ? self.ballot.ballotNote : @"";
    //self.ballotMeasureInstructionsLabel.text = self.ballot.instructions != nil ? self.ballot.instructions : @"";
}


@end
