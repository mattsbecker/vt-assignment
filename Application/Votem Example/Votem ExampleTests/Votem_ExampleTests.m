//
//  Votem_ExampleTests.m
//  Votem ExampleTests
//
//  Created by Matt on 8/12/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "VTContest.h"
#import "VTRankedChoiceBallot.h"
#import "VTSelectOneBallot.h"
#import "VTSelectTwoBallot.h"

@interface Votem_ExampleTests : XCTestCase
@end

@implementation Votem_ExampleTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
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

- (void)testCanCreateEmptyContestWithName {
    NSString *contestName = @"Test Contest";
    VTContest *contest = [self contestWithName:contestName];
    XCTAssertTrue([contest.name isEqualToString:contestName]);
}

- (void)testCanCrateSelectOneBallot {
    NSString *ballotTitle = @"For Cheif Dairy Queen";
    NSString *subtitle = @"Shall Justice Mint C. Chip of the Supreme Court of the State of Ice Create be retained in office for another term?";
    NSString *instructions = @"Select the checkbox before the word \"YES\" if you wish the official to remain in office. \n Select the checkbox before the word \"NO\" if you do not wish the official to remain in office";
    NSArray *ballotOptions = [self chooseOneBallotOptions];
    
    // Test to ensure the ballot is successfully created and is of the correct type
    VTSelectOneBallot *selectOneBallot = [[VTSelectOneBallot alloc] init];
    XCTAssertNotNil(selectOneBallot);
    XCTAssertEqualObjects(@(selectOneBallot.type), @(kVTBallotTypeSelectOne));
    XCTAssertNotEqualObjects(@(selectOneBallot.type), @(kVTBallotTypeSelectTwo));
    
    // After creation is verified, ensure the ballot properties are correctly stored
    selectOneBallot.title = ballotTitle;
    selectOneBallot.subtitle = subtitle;
    selectOneBallot.instructions = instructions;
    selectOneBallot.options = ballotOptions;
    
    XCTAssertEqual(selectOneBallot.title, ballotTitle);
    XCTAssertEqual(selectOneBallot.subtitle, subtitle);
    XCTAssertEqual(selectOneBallot.instructions, instructions);
    XCTAssertTrue(selectOneBallot.options.count == 2);
}

- (void)testCanCrateSelectOneWithNoteBallot {
    NSString *ballotTitle = @"Ballot Issue";
    NSString *subtitle = @"Constiutional Initiative No. 116";
    NSString *instructions = @"Vote by selecting one checkbox";
    NSArray *ballotOptions = [self chooseOneWithNoteBallotOptions];
    NSString *ballotNote = @"Make Vanilla (Over Chocolate) the official best flavor";
    
    // Test to ensure the ballot is successfully created and is of the correct type
    VTSelectOneBallot *selectOneBallot = [[VTSelectOneBallot alloc] init];
    XCTAssertNotNil(selectOneBallot);
    XCTAssertEqualObjects(@(selectOneBallot.type), @(kVTBallotTypeSelectOne));
    XCTAssertNotEqualObjects(@(selectOneBallot.type), @(kVTBallotTypeRankedChoice));
    
    // After creation is verified, ensure the ballot properties are correctly stored
    selectOneBallot.title = ballotTitle;
    selectOneBallot.subtitle = subtitle;
    selectOneBallot.instructions = instructions;
    selectOneBallot.options = ballotOptions;
    selectOneBallot.ballotNote = ballotNote;
    
    XCTAssertEqual(selectOneBallot.title, ballotTitle);
    XCTAssertEqual(selectOneBallot.subtitle, subtitle);
    XCTAssertEqual(selectOneBallot.instructions, instructions);
    XCTAssertEqual(selectOneBallot.ballotNote, ballotNote);
    XCTAssertTrue(selectOneBallot.options.count == 2);
}

- (void)testCanCreateSelectTwoBallot {
    NSString *ballotTitle = @"For State Rep. District M&M";
    NSString *instructions = @"Vote for two";
    NSArray *ballotOptions = [self chooseTwoBallotOptions];
    
    // Test to ensure the ballot is successfully created and is of the correct type
    VTSelectTwoBallot *selectTwoBallot = [[VTSelectTwoBallot alloc] init];
    XCTAssertNotNil(selectTwoBallot);
    XCTAssertEqualObjects(@(selectTwoBallot.type), @(kVTBallotTypeSelectTwo));
    XCTAssertNotEqualObjects(@(selectTwoBallot.type), @(kVTBallotTypeSelectOne));
    
    // After creation is verified, ensure the ballot properties are correctly stored
    selectTwoBallot.title = ballotTitle;
    selectTwoBallot.instructions = instructions;
    selectTwoBallot.options = ballotOptions;
    
    XCTAssertEqual(selectTwoBallot.title, ballotTitle);
    XCTAssertEqual(selectTwoBallot.instructions, instructions);
    XCTAssertTrue(selectTwoBallot.options.count == 3);
}

- (VTContest *)contestWithName:(NSString *)contestName {
    VTContest *contest = [[VTContest alloc] init];
    contest.name = contestName;
    return contest;
}

- (NSArray *)rankedChoiceBallotOptions {
    NSString *option1 = @"Reese WithoutASpoon - Democrat for C.I.C \n Cherry Garcia - Democrat for Vice Ice";
    NSString *option2 = @"Choco 'Chip' Dough - Republican for C.I.C \n Carmela Coney - Republican for Vice Ice";
    NSString *option3 = @"Magic Browny - Independent for C.I.C \n Phish Food - Independent for Vice Ice";
    
    NSArray *rankedChoiceOptions = [NSArray arrayWithObjects:option1, option2, option3, nil];
    
    return rankedChoiceOptions;
}

- (NSArray *)chooseTwoBallotOptions {
    NSArray *chooseTwoOptions = [NSArray arrayWithObjects:@"P. Nut Butter (REPUBLICAN)", @"Cream C. Kol (INDEPENDENT)", @"Marsh Mallow (DEMOCRAT)", nil];
    return chooseTwoOptions;
}

- (NSArray *)chooseOneBallotOptions {
    NSArray *chooseTwoOptions = [NSArray arrayWithObjects:@"YES", @"NO", nil];
    return chooseTwoOptions;
}

- (NSArray *)chooseOneWithNoteBallotOptions {
    NSArray *chooseTwoOptions = [NSArray arrayWithObjects:@"YES ON CI - 116 (FOR VANILLA)", @"NO ON 116 (NO ON VANILLA)", nil];
    return chooseTwoOptions;
}


@end
