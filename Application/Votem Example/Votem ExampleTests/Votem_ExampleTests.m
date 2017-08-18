//
//  Votem_ExampleTests.m
//  Votem ExampleTests
//
//  Created by Matt on 8/12/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "VTContest.h"
#import "VTBallotOption.h"
#import "VTBallotFactory.h"
#import "VTRankedChoiceBallot.h"
#import "VTSelectOneBallot.h"
#import "VTSelectTwoBallot.h"

NSInteger const kVTTestableContestId = 100;

@interface Votem_ExampleTests : XCTestCase

// Select-One ballot properties
@property(nonatomic, strong) NSString *selectOneBallotTitle;
@property(nonatomic, strong) NSString *selectOneBallotSubtitle;
@property(nonatomic, strong) NSString *selectOneBallotInstructions;
@property(nonatomic, strong) NSArray *selectOneBallotOptions;

// Select-One with note properties
@property(nonatomic, strong) NSString *selectOneWithNoteBallotTitle;
@property(nonatomic, strong) NSString *selectOneWithNoteBallotSubtitle;
@property(nonatomic, strong) NSString *selectOneWithNoteBallotInstructions;
@property(nonatomic, strong) NSString *selectOneWithNoteBallotNote;
@property(nonatomic, strong) NSArray *selectOneWithNoteBallotOptions;

// Select-two properties
@property(nonatomic, strong) NSString *selectTwoBallotTitle;
@property(nonatomic, strong) NSString *selectTwoBallotInstructions;
@property(nonatomic, strong) NSArray *selectTwoBallotOptions;

// Ranked-choice properties
@property(nonatomic, strong) NSString *rankedChoiceBallotTitle;
@property(nonatomic, strong) NSString *rankedChoiceBallotSubtitle;
@property(nonatomic, strong) NSString *rankedChoiceBallotInstructions;
@property(nonatomic, strong) NSArray *rankedChoiceBallotOptions;


// Start and End Dates for contests
@property(nonatomic, strong) NSDate *contestValidStartDate; // Valid start date, not in future
@property(nonatomic, strong) NSDate *contestInvalidStartDate; // Invalid start date, in the future

@property(nonatomic, strong) NSDate *contestValidEndDate; // Valid end date, in the future
@property(nonatomic, strong) NSDate *contestExpiredEndDate; // Invalid end date, in the past
@end

@implementation Votem_ExampleTests

- (void)setUp {
    [super setUp];
    // Create a start date that is only one minute old; and an expired date that expired one minute ago
    self.contestValidStartDate = [NSDate dateWithTimeIntervalSinceNow:-60];
    self.contestExpiredEndDate = [NSDate dateWithTimeIntervalSinceNow:-60];
    
    // Create a date one date in the future for invalid start date and valid end date
    self.contestInvalidStartDate = [NSDate dateWithTimeIntervalSinceNow:1440];
    self.contestValidEndDate = [NSDate dateWithTimeIntervalSinceNow:1440];
    
    // Create some persisted select-one ballot properties for testing
    self.selectOneBallotTitle = @"For Cheif Dairy Queen";
    self.selectOneBallotSubtitle = @"Shall Justice Mint C. Chip of the Supreme Court of the State of Ice Create be retained in office for another term?";
    self.selectOneBallotInstructions = @"Select the checkbox before the word \"YES\" if you wish the official to remain in office. \nSelect the checkbox before the word \"NO\" if you do not wish the official to remain in office";
    self.selectOneBallotOptions = [self chooseOneBallotOptions];
    
    // select-one with a note...
    self.selectOneWithNoteBallotTitle = @"Ballot Issue";
    self.selectOneWithNoteBallotSubtitle = @"Constiutional Initiative No. 116";
    self.selectOneWithNoteBallotInstructions = @"Vote by selecting one checkbox";
    self.selectOneWithNoteBallotNote = @"Make Vanilla (Over Chocolate) the official best flavor. \nThis is a fiercely debated topic and CI - 116 would offically enumerate in writted legislative text in perpetuity which flavor has favor – namely vanilla is better, unequivocally, then chocolate.";
    self.selectOneWithNoteBallotOptions = [self chooseOneWithNoteBallotOptions];

    // select-two
    self.selectTwoBallotTitle = @"For State Rep. District M&M";
    self.selectTwoBallotInstructions = @"Vote for two";
    self.selectTwoBallotOptions = [self chooseTwoBallotOptions];
    
    // ranked-choice
    self.rankedChoiceBallotTitle = @"For Commander in Ice Cream and Vice Ice";
    self.rankedChoiceBallotSubtitle = @"Ranked choice voting (instant runoff)";
    self.rankedChoiceBallotInstructions = @"Rank candidates in order of choice. Mark your favorite candidate as first choice, and then indicate your second and additional back-up choices in order of choice. You may rank as many candidates as you want.";

}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testCanCreateEmptyNamedContest {
    NSString *contestName = @"Test Contest";
    VTContest *contest = [self contestWithName:contestName];
    XCTAssertNotNil(contest);
    XCTAssertTrue([contest.name isEqualToString:contestName]);
}

- (void)testCanCreateNamedContestOneBallot {
    NSString *contestName = @"One Ballot Contest";
    VTSelectOneBallot *selectOneBallot = (VTSelectOneBallot*)[VTBallotFactory ballotWithType:kVTBallotTypeSelectOne title:self.selectOneBallotTitle subTitle:self.selectOneBallotSubtitle instructions:self.selectOneBallotTitle ballotNote:nil options:[self chooseOneBallotOptions]];
    

    VTContest *contest = [self contestWithName:contestName];
    contest.contestId = @(kVTTestableContestId);
    contest.startDate = self.contestValidStartDate;
    contest.endDate = self.contestValidEndDate;
    contest.enabled = YES;
    
    XCTAssertNotNil(contest);
    XCTAssertTrue([contest.name isEqualToString:contestName]);
    XCTAssertTrue(contest.contestId.integerValue == kVTTestableContestId);
    XCTAssertTrue(contest.enabled);
    
    contest.availableBallots = @[selectOneBallot];
    
    XCTAssertTrue(contest.availableBallots.count == 1);
    XCTAssertTrue([contest.availableBallots[0] isKindOfClass:VTBallot.class]);
}

- (void)testCanCrateRankedChoiceBallot {
    // Test to ensure the ballot is successfully created and is of the correct type
    VTRankedChoiceBallot *rankedChoiceBallot = (VTRankedChoiceBallot*)[VTBallotFactory ballotWithType:kVTBallotTypeRankedChoice title:self.rankedChoiceBallotTitle subTitle:self.rankedChoiceBallotSubtitle instructions:self.rankedChoiceBallotInstructions ballotNote:nil options:[self rankedChoiceBallotOptions]];
    
    XCTAssertNotNil(rankedChoiceBallot);
    XCTAssertEqualObjects(@(rankedChoiceBallot.type), @(kVTBallotTypeRankedChoice));
    XCTAssertNotEqualObjects(@(rankedChoiceBallot.type), @(kVTBallotTypeSelectTwo));
    
    // After creation is verified, ensure the ballot properties are correctly stored
    XCTAssertEqual(rankedChoiceBallot.title, self.rankedChoiceBallotTitle);
    XCTAssertEqual(rankedChoiceBallot.subtitle, self.rankedChoiceBallotSubtitle);
    XCTAssertEqual(rankedChoiceBallot.instructions, self.rankedChoiceBallotInstructions);
    XCTAssertTrue(rankedChoiceBallot.options.count == 3);
}


- (void)testCanCrateSelectOneBallot {
    // Test to ensure the ballot is successfully created and is of the correct type
    VTSelectOneBallot *selectOneBallot = (VTSelectOneBallot*)[VTBallotFactory ballotWithType:kVTBallotTypeSelectOne title:self.selectOneBallotTitle subTitle:self.selectOneBallotSubtitle instructions:self.selectOneBallotInstructions ballotNote:nil options:[self chooseOneBallotOptions]];
    
    XCTAssertNotNil(selectOneBallot);
    XCTAssertEqualObjects(@(selectOneBallot.type), @(kVTBallotTypeSelectOne));
    XCTAssertNotEqualObjects(@(selectOneBallot.type), @(kVTBallotTypeSelectTwo));
    
    // After creation is verified, ensure the ballot properties are correctly stored
    XCTAssertEqual(selectOneBallot.title, self.selectOneBallotTitle);
    XCTAssertEqual(selectOneBallot.subtitle, self.selectOneBallotSubtitle);
    XCTAssertEqual(selectOneBallot.instructions, self.selectOneBallotInstructions);
    XCTAssertTrue(selectOneBallot.options.count == 2);
}

- (void)testCastVoteForSelectOneBallot {
    // Test to ensure the ballot is successfully created and is of the correct type
    VTSelectOneBallot *selectOneBallot = (VTSelectOneBallot*)[VTBallotFactory ballotWithType:kVTBallotTypeSelectOne title:self.selectOneBallotTitle subTitle:self.selectOneBallotSubtitle instructions:self.selectOneBallotInstructions ballotNote:nil options:[self chooseOneBallotOptions]];
    
    XCTAssertNotNil(selectOneBallot);
    XCTAssertEqualObjects(@(selectOneBallot.type), @(kVTBallotTypeSelectOne));
    XCTAssertNotEqualObjects(@(selectOneBallot.type), @(kVTBallotTypeSelectTwo));
    
    // After creation is verified, ensure the ballot properties are correctly stored
    XCTAssertEqual(selectOneBallot.title, self.selectOneBallotTitle);
    XCTAssertEqual(selectOneBallot.subtitle, self.selectOneBallotSubtitle);
    XCTAssertEqual(selectOneBallot.instructions, self.selectOneBallotInstructions);
    XCTAssertTrue(selectOneBallot.options.count == 2);
    
    [selectOneBallot addKeyValueObserver:self];
    [selectOneBallot selectOption:selectOneBallot.options[0]];
    XCTAssertEqual(selectOneBallot.selections[0], selectOneBallot.options[0]);
    NSLog(@"The user casted a vote for : %@, the option title is: %@", selectOneBallot.title, selectOneBallot.selections[0].title);
    [selectOneBallot selectOption:selectOneBallot.options[1]];
    XCTAssertEqual(selectOneBallot.selections[0], selectOneBallot.options[1]);
    NSLog(@"The user casted a vote for : %@, the option title is: %@", selectOneBallot.title, selectOneBallot.selections[0].title);
}


- (void)testCanCrateSelectOneWithNoteBallot {
    VTSelectOneBallot *selectOneBallot = (VTSelectOneBallot*)[VTBallotFactory ballotWithType:kVTBallotTypeSelectOne title:self.selectOneWithNoteBallotTitle subTitle:self.selectOneWithNoteBallotSubtitle instructions:self.selectOneWithNoteBallotInstructions ballotNote:self.selectOneWithNoteBallotNote options:[self chooseOneWithNoteBallotOptions]];
    
    // Test to ensure the ballot is successfully created and is of the correct type
    XCTAssertNotNil(selectOneBallot);
    XCTAssertEqualObjects(@(selectOneBallot.type), @(kVTBallotTypeSelectOne));
    XCTAssertNotEqualObjects(@(selectOneBallot.type), @(kVTBallotTypeRankedChoice));
    
    // After creation is verified, ensure the ballot properties are correctly stored
    XCTAssertEqual(selectOneBallot.title, self.selectOneWithNoteBallotTitle);
    XCTAssertEqual(selectOneBallot.subtitle, self.selectOneWithNoteBallotSubtitle);
    XCTAssertEqual(selectOneBallot.instructions, self.selectOneWithNoteBallotInstructions);
    XCTAssertEqual(selectOneBallot.ballotNote, self.selectOneWithNoteBallotNote);
    XCTAssertTrue(selectOneBallot.options.count == 2);
}

- (void)testCanCreateSelectTwoBallot {
    // Test to ensure the ballot is successfully created and is of the correct type
    VTSelectTwoBallot *selectTwoBallot = (VTSelectTwoBallot*)[VTBallotFactory ballotWithType:kVTBallotTypeSelectTwo title:self.selectTwoBallotTitle subTitle:nil instructions:self.selectTwoBallotInstructions ballotNote:nil options:[self chooseTwoBallotOptions]];
    XCTAssertNotNil(selectTwoBallot);
    XCTAssertEqualObjects(@(selectTwoBallot.type), @(kVTBallotTypeSelectTwo));
    XCTAssertNotEqualObjects(@(selectTwoBallot.type), @(kVTBallotTypeSelectOne));
    
    // After creation is verified, ensure the ballot properties are correctly stored
    XCTAssertEqual(selectTwoBallot.title, self.selectTwoBallotTitle);
    XCTAssertEqual(selectTwoBallot.instructions, self.selectTwoBallotInstructions);
    XCTAssertTrue(selectTwoBallot.options.count == 3);
}

- (VTContest *)contestWithName:(NSString *)contestName {
    VTContest *contest = [[VTContest alloc] init];
    contest.name = contestName;
    return contest;
}

- (NSArray *)rankedChoiceBallotOptions {
    VTBallotOption *option1 = [[VTBallotOption alloc] init];
    option1.title = @"Reese WithoutASpoon - Democrat for C.I.C \nCherry Garcia - Democrat for Vice Ice";

    VTBallotOption *option2 = [[VTBallotOption alloc] init];
    option2.title = @"Choco 'Chip' Dough - Republican for C.I.C \nCarmela Coney - Republican for Vice Ice";
    
    VTBallotOption *option3 = [[VTBallotOption alloc] init];
    option3.title = @"Magic Browny - Independent for C.I.C \nPhish Food - Independent for Vice Ice";
    
    NSArray *rankedChoiceOptions = [NSArray arrayWithObjects:option1, option2, option3, nil];
    
    return rankedChoiceOptions;
}

- (NSArray *)chooseTwoBallotOptions {
    VTBallotOption *option1 = [[VTBallotOption alloc] init];
    option1.title = @"P. Nut Butter (REPUBLICAN)";
    
    VTBallotOption *option2 = [[VTBallotOption alloc] init];
    option2.title = @"Cream C. Kol (INDEPENDENT)";

    VTBallotOption *option3 = [[VTBallotOption alloc] init];
    option3.title = @"Marsh Mallow (DEMOCRAT)";

    NSArray *chooseTwoOptions = [NSArray arrayWithObjects:option1, option2, option3, nil];
    return chooseTwoOptions;
}

- (NSArray *)chooseOneBallotOptions {
    VTBallotOption *option1 = [[VTBallotOption alloc] init];
    option1.title = @"YES";
    
    VTBallotOption *option2 = [[VTBallotOption alloc] init];
    option2.title = @"NO";

    NSArray *chooseTwoOptions = [NSArray arrayWithObjects:option1, option2, nil];
    return chooseTwoOptions;
}

- (NSArray *)chooseOneWithNoteBallotOptions {
    VTBallotOption *option1 = [[VTBallotOption alloc] init];
    option1.title = @"YES ON CI - 116 (FOR VANILLA)";
    
    VTBallotOption *option2 = [[VTBallotOption alloc] init];
    option2.title = @"NO ON 116 (NO ON VANILLA)";

    NSArray *chooseTwoOptions = [NSArray arrayWithObjects:option1, option2, nil];
    return chooseTwoOptions;
}

@end
