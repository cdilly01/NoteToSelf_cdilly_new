//
//  NoteToSelfTests_cdilly.m
//  NoteToSelfTests_cdilly
//
//  Created by A Student on 6/8/14.
//  Copyright (c) 2014 msse650. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Note.h"
#import "NoteSvcArchive.h"
#import <SenTestingKit/SenTestingKit.h>


@interface NoteMgrSBTests : XCTestCase

@end

@implementation NoteMgrSBTests

NoteSvcArchive *noteSvc = nil;

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.+
    noteSvc = [[NoteSvcArchive alloc] init];}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testNoteSvcArchive
{
    NSLog(@" *** Starting testNoteSvcArchive ***");
    Note *note = [[Note alloc] init];
    
    note.noteText = @"That's one fine note";
    
    [noteSvc createNote:(Note *) note];
    int count = [[noteSvc retrieveAllNotes] count];
    
    NSLog(@"*** The count: %i", count);
    NSLog(@"*** Ending testNoteSvcArchive test ***");
    
    //XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
    //XCTFail(@"Unit Tests are not implemented yet");
}

- (void)testNoteSvcArchive2
{
    NSLog(@" *** Starting testContactSvcArchive ***");
    int initialCount = [[noteSvc retrieveAllNotes] count];
    
    Note *note = [[Note alloc] init];
    note.noteText = @"That's one fine note";
    
    [noteSvc createNote:(Note *) note];
    int finalCount = [[noteSvc retrieveAllNotes] count];
    
    XCTAssertEqual(initialCount + 1, finalCount, @"initial count %d, final count %d", initialCount, finalCount);

    NSLog(@"*** Ending testNotesSvcArchive test ***");
    
    NSLog(@"*** Ending testNotesSvcArchive test ***");
}


@end
