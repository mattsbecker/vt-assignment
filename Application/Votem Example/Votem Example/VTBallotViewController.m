//
//  VTBallotViewController.m
//  Votem Example
//
//  Created by Matt on 8/18/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import "VTBallotViewController.h"
#import "UIFont+VTFonts.h"
#import "VTRouter.h"
#import "VTTableViewCell.h"
#import "VTTextEntryTableViewCell.h"

@interface VTBallotViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *ballotMeasureTableView;
@property (strong, nonatomic) IBOutlet UILabel *ballotMeasureTitle;
@property (strong, nonatomic) IBOutlet UILabel *ballotMeasureSubtitle;
@property (strong, nonatomic) IBOutlet UILabel *ballotMeasureNotesLabel;
@property (strong, nonatomic) IBOutlet UILabel *ballotMeasureInstructionsLabel;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *actionBarButtonItem;
@end

@implementation VTBallotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ballotMeasureTableView.delegate = self;
    self.ballotMeasureTableView.dataSource = self;
    [VTBallotViewController registerTableViewCells:self.ballotMeasureTableView];
    
    // Reload our data source!
    [self.ballotMeasureTableView reloadData];
    
    // Register for UITextFieldNotifications
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleTextFieldDidChangeNotification:) name:UITextFieldTextDidChangeNotification object:nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.ballot != nil) {
        [self configureViewForBallot];
    }

    if (self.ballot && self.contest != nil) {
        [self configureToolbar];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.ballot.allowsWriteIn) {
        return 2;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 1;
    }
    return self.ballot.options.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0 && self.ballot.instructions) {
        return self.ballot.instructions.lowercaseString;
    } else {
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // If this is the second section, the only row available will be an "add write in" row
    if (indexPath.section == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WriteInCell" forIndexPath:indexPath];
        cell.textLabel.text = NSLocalizedString(@"BALLOT.ADD_WRITE_IN", @"Add write in text");
        return cell;
    }
    VTBallotOption *option = self.ballot.options[indexPath.row];
    UITableViewCell *cell;
    if (self.ballot.allowsWriteIn && option.writeIn) {
        VTTextEntryTableViewCell *editTextCell = [self editableTextCellForTableView:tableView ballotObject:option indexPath:indexPath];
        cell = editTextCell;
    } else {
        VTTableViewCell *standardCell = [self standardTextCellForTableView:tableView ballotObject:option indexPath:indexPath];
        cell = standardCell;
    }
    // If this selection has been chosen by the user, mark it as such
    if ([self.ballot.selections containsObject:option]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.editingAccessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.editingAccessoryType = UITableViewCellEditingStyleNone;
    }
    
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    // If we've hit the "add write in cell", ensure the editing style is set none
    if (indexPath.section == 1) {
        return UITableViewCellEditingStyleNone;
    }
    
    VTBallotOption *option = self.ballot.options[indexPath.row];
    if (option.writeIn) {
        return UITableViewCellEditingStyleDelete;
    }
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // If the add write-in cell was selected, handle preparing the data source for it's addition
    if (indexPath.section == 1 && self.ballot.type == kVTBallotTypeRankedChoice && self.ballot.allowsWriteIn) {
        [self.ballot prepareForWriteInAdditionWithText:@""];
        [self.ballotMeasureTableView beginUpdates];
        [self.ballotMeasureTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
        [self.ballotMeasureTableView endUpdates];
    }
    
    VTBallotOption *option = self.ballot.options[indexPath.row];
    if ([self.ballot.selections containsObject:option]) {
        [self.ballot deselectOption:option];
    } else {
        [self.ballot selectOption:option];
    }
    [self reloadTableViewSection:indexPath.section];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (UITableViewCellEditingStyleDelete) {
        VTBallotOption *option = self.ballot.options[indexPath.row];
        [self.ballot removeWriteInSelection:option];
        [self.ballotMeasureTableView reloadData];
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && self.ballot.type == kVTBallotTypeRankedChoice) {
        VTBallotOption *option = self.ballot.options[indexPath.row];
        if ([self.ballot.selections containsObject:option]) {
            return YES;
        }
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    // If either the source or destination sections belong to the "add write in" row, ensure no editing may occur
    if (sourceIndexPath.section != 0 || destinationIndexPath.section != 0) {
        return;
    }
    VTBallotOption *option = self.ballot.options[sourceIndexPath.row];
    // Ensure only ranked choice ballot types can be reordered
    if (self.ballot.type != kVTBallotTypeRankedChoice) {
        return;
    }
    [self.ballot moveSelection:option fromPosition:sourceIndexPath.row toPosition: destinationIndexPath.row];
    [self.ballotMeasureTableView reloadData];
}

# pragma mark --- Instance Methods ---

# pragma mark --- Private Methods ---

- (VTTableViewCell *)standardTextCellForTableView:(UITableView *)tableView ballotObject:(VTBallotOption *)ballot indexPath:(NSIndexPath *)indexPath {
    VTTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[VTTableViewCell vt_reuseIdentifier]];
    cell.tintColor = [UIColor vt_highlightBrandColor];
    cell.contentTextLabel.text = self.ballot.options[indexPath.row].title;
    cell.contentDetailTextLabel.text = @"";
    cell.positionTextLabel.text = @(indexPath.row + 1).stringValue;
    cell.contentTextLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont vt_footnoteFont];
    return cell;
}

- (VTTextEntryTableViewCell *)editableTextCellForTableView:(UITableView *)tableView ballotObject:(VTBallotOption *)ballot indexPath:(NSIndexPath *)indexPath {
    VTTextEntryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[VTTextEntryTableViewCell vt_reuseIdentifier]];
    cell.tintColor = [UIColor vt_highlightBrandColor];
    cell.textField.text = self.ballot.options[indexPath.row].title;
    cell.textField.placeholder = @"Enter your write in";
    cell.textField.font = [UIFont vt_formFieldFont];
    return cell;
}

+ (void)registerTableViewCells:(UITableView*)tableView {
    [tableView registerNib:[VTTableViewCell vt_tableViewCellNib] forCellReuseIdentifier:[VTTableViewCell vt_reuseIdentifier]];
    [tableView registerNib:[VTTextEntryTableViewCell vt_tableViewCellNib] forCellReuseIdentifier:[VTTextEntryTableViewCell vt_reuseIdentifier]];
    [tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"WriteInCell"];
}

- (void)configureToolbar {
    
    // Retrieve the completion status of the current contest
    NSDictionary *contestStatus = [self.contest evaluateContestCompletionStatus];
    
    // Configure the toolbar style
    self.navigationController.toolbar.barTintColor = [UIColor vt_tertiaryBrandColor];
    self.navigationController.toolbar.translucent = YES;
    
    // Create our buttons
    
    NSNumber *completed = (NSNumber*)contestStatus[@"completed"];
    NSNumber *avaialable = (NSNumber*)contestStatus[@"available"];
    NSNumber *completedBool = (NSNumber*)contestStatus[@"isComplete"];
    
    NSString *barButtonString = @"Complete and Submit";
    NSString *title = [NSString stringWithFormat:@"%zd of %zd Completed", completed.integerValue, avaialable.integerValue];
    NSInteger nextBallotIndex = [self.contest.availableBallots indexOfObject:self.ballot] + 1;
    
    if (nextBallotIndex <= self.contest.availableBallots.count - 1) {
        barButtonString = @"Next";
    }
    
    self.title = title;
    [self.actionBarButtonItem setTitle:barButtonString];
    self.actionBarButtonItem.target = self;
    self.actionBarButtonItem.action = @selector(handleActionButtonPress:);
}

- (VTTextEntryTableViewCell *)textEntryCellForTextField:(UITextField*)textField {
    VTTextEntryTableViewCell *cell = (VTTextEntryTableViewCell*)textField.superview.superview;
    return cell;
}

- (void)handleTextFieldDidChangeNotification:(NSNotification*)notification {
    // Get the field from the notification, and the cell to which it belongs
    UITextField *field = notification.object;
    VTTextEntryTableViewCell *cell = [self textEntryCellForTextField:field];
    
    // Get the index path of the cell and lookup the ballotOption for the index path
    NSIndexPath *indexPathForCell = [self.ballotMeasureTableView indexPathForCell:cell];
    VTBallotOption *ballotOption = self.ballot.options[indexPathForCell.row];

    // Go ahead and update the text!
    [ballotOption updateText:field.text];
}


- (void)configureViewForBallot {
    if (!self.ballot) {
        return;
    }
    self.ballotMeasureTitle.text = self.ballot.title != nil ? self.ballot.title : @"";
    self.ballotMeasureSubtitle.text = self.ballot.subtitle != nil ? self.ballot.subtitle : @"";
    self.ballotMeasureNotesLabel.text = self.ballot.ballotNote != nil ? self.ballot.ballotNote : @"";
    
    if (self.ballot.type == kVTBallotTypeRankedChoice) {
        self.ballotMeasureTableView.editing = YES;
        self.ballotMeasureTableView.allowsSelection = YES;
        self.ballotMeasureTableView.allowsSelectionDuringEditing = YES;
    }
}

- (void) reloadTableViewSection:(NSInteger)section {
    [self.ballotMeasureTableView beginUpdates];
    [self.ballotMeasureTableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
    [self.ballotMeasureTableView endUpdates];
}

- (void)handleActionButtonPress:(UIBarButtonItem*)sender {
    NSInteger ballotIndex = [self.contest.availableBallots indexOfObject:self.ballot];
    if (ballotIndex < self.contest.availableBallots.count - 1) {
        [self showNextBallot];
    } else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Submit your selections" message:@"Continuing will submit your selections. Would you like to review all ballots?" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *submitAction = [UIAlertAction actionWithTitle:@"No, I want to submit my selections now" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            [self submit];
        }];
        UIAlertAction *reviewAction = [UIAlertAction actionWithTitle:@"Yes, I want to review my selections" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            [self review];
        }];
        [alertController addAction:reviewAction];
        [alertController addAction:submitAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)submit {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)review {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showNextBallot {
    NSInteger nextBallotIndex = [self.contest.availableBallots indexOfObject:self.ballot] + 1;
    if (nextBallotIndex <= self.contest.availableBallots.count) {
        self.title = @"";
        VTBallot *nextBallot = (VTBallot*)[self.contest.availableBallots objectAtIndex:nextBallotIndex];
        VTBallotViewController *ballotViewController = [[VTBallotViewController alloc] initWithNibName:@"VTBallotViewController" bundle:nil];
        ballotViewController.ballot = nextBallot;
        ballotViewController.contest = self.contest;
        [self.navigationController pushViewController:ballotViewController animated:YES];
    }
}


@end
