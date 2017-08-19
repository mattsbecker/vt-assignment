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

- (void)viewDidAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setToolbarHidden:NO animated:YES];
    if (self.ballot && self.contest != nil) {
        [self configureToolbar];
    }
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

- (void)configureToolbar {
    
    // Retrieve the completion status of the current contest
    NSDictionary *contestStatus = [self.contest evaluateContestCompletionStatus];
    
    // Configure the toolbar style
    self.navigationController.toolbar.barTintColor = [UIColor vt_tertiaryBrandColor];
    self.navigationController.toolbar.translucent = YES;
    
    // Create our buttons
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"Previous" style:UIBarButtonItemStylePlain target:nil action:nil];
    leftItem.tintColor = [UIColor whiteColor];
    UIBarButtonItem *spacerLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:nil action:nil];
    rightItem.tintColor = [UIColor whiteColor];
    UIBarButtonItem *spacerRight = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    NSNumber *completed = (NSNumber*)contestStatus[@"completed"];
    NSNumber *avaialable = (NSNumber*)contestStatus[@"available"];
    NSNumber *completedBool = (NSNumber*)contestStatus[@"isComplete"];
    BOOL completedValue = completedBool.boolValue;
    
    // Create the submit/completed string
    NSString *submitString = [NSString stringWithFormat:@"%zd of %zd Completed", completed.integerValue, avaialable.integerValue];
    if (completedValue) {
        submitString = @"Complete and Submit";
    }
    
    // Create the submit item
    UIBarButtonItem *submitItem = [[UIBarButtonItem alloc] initWithTitle:submitString style:UIBarButtonItemStylePlain target:nil action:nil];

    if (!completedBool) {
        submitItem.tintColor = [UIColor colorWithWhite:.90 alpha:1.0];
        submitItem.enabled = NO;
    } else {
        submitItem.tintColor = [UIColor whiteColor];
        submitItem.enabled = YES;
    }
    
    NSArray<UIBarButtonItem*> *barButtonItems = @[leftItem, spacerLeft, submitItem, spacerRight, rightItem];
    [self.navigationController.toolbar setItems:barButtonItems animated:YES];
}

- (void)configureViewForBallot {
    if (!self.ballot) {
        return;
    }
    self.ballotMeasureTitle.text = self.ballot.title != nil ? self.ballot.title : @"";
    self.ballotMeasureSubtitle.text = self.ballot.subtitle != nil ? self.ballot.subtitle : @"";
    self.ballotMeasureNotesLabel.text = self.ballot.ballotNote != nil ? self.ballot.ballotNote : @"";
}


@end
