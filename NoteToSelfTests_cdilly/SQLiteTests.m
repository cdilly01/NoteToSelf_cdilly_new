//
//  SQLiteTests.m
//  NoteToSelfTests_cdilly
//
//  Created by A Student on 6/8/14.
//  Copyright (c) 2014 msse650. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Note.h"
#import "NoteSvcSQLite.h"

@interface SQLiteTests : XCTestCase

@end

@implementation SQLiteTests
NoteSvcSQLite *noteSvc = nil;

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    noteSvc= [[NoteSvcSQLite alloc] init];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCreateNote
{
    NSLog(@"  ");
    NSLog(@"*** Starting TestCreateNote ***");
  
    Note *note = [[Note alloc] init];
    note.noteText = @"This is one fine note!";
    [noteSvc createNote:note];
    
    NSLog(@"*** ending TestCreateNote ***");
    NSLog(@"  ");
}

- (void)testRetrieveAllNotes
{
    NSLog(@"  ");
    NSLog(@"*** Starting TestRetrieveAllNotes ***");
    
    Note *note = [[Note alloc] init];
    note.noteText = @"This is one fine note!";
    [noteSvc createNote:note];
    
    NSMutableArray *notes = [noteSvc retrieveAllNotes];
    
    NSLog(@"***  number of notes: %i", notes.count);
    NSLog(@"*** ending TestRetieveAllNotes ***");
    NSLog(@"  ");
}

- (void)testUpdateNote
{
    NSLog(@"  ");
    NSLog(@"*** Starting TestUpdateNote ***");
    
    
    Note *note = [[Note alloc] init];
    note.noteText = @"This is one fine note!";
    [noteSvc createNote:note];
    
    NSMutableArray *notes = [noteSvc retrieveAllNotes];
    
    NSLog(@"***  number of notes: %i", notes.count);
    note.noteText = @"This is one fine note!";
    [noteSvc updateNote:note];
    
    NSLog(@"*** ending TestUpdateNote ***");
    NSLog(@"  ");
}

- (void)testDeleteNote
{
    NSLog(@"  ");
    NSLog(@"*** Starting TestDeleteNote ***");
    
    Note *note = [[Note alloc] init];
    note.noteText = @"This is one fine note!";
    [noteSvc createNote:note];
    
    NSMutableArray *notes = [noteSvc retrieveAllNotes];
    
    NSLog(@"***  number of contacts: %i", notes.count);
    note.noteText = @"This is one fine note!";
    [noteSvc updateNote:note];
    
    [noteSvc deleteNote:note];
    
    NSLog(@"*** ending TestDeleteNote ***");
    NSLog(@"  ");
}

@end
