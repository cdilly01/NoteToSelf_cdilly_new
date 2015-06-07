//
//  NoteSvcArchive.m
//  NoteToSelf_cdilly
//
//  Created by A Student on 6/8/14.
//  Copyright (c) 2014 msse650. All rights reserved.
//

#import "NoteSvcArchive.h"

@implementation NoteSvcArchive

NSString *filePath;
NSMutableArray *notes;

-(id) init {
    NSArray *dirPaths =
    NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                        NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    filePath = [[NSString alloc] initWithString: [docsDir
                                                  stringByAppendingPathComponent: @"Notes.archive"]];
    [self readArchive];
    return self;
}

-(void) readArchive {
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath: filePath])
    {
        notes = [NSKeyedUnarchiver unarchiveObjectWithFile: filePath];
    }
    else
    {
        notes = [NSMutableArray array];
    }
}

-(void) writeArchive {
    [NSKeyedArchiver archiveRootObject:notes toFile:filePath];
}

- (Note *) createNote: (Note *) note
{
    NSLog(@"NoteSvc.createNote: %@", [note description]);
    [notes addObject: note];
    [self writeArchive];
    
    return note;
}

- (NSMutableArray *) retrieveAllNotes
{
    return notes;
}

- (Note *) updateNote: (Note *) note
{
    return note;
}

- (Note *) deleteNote: (Note *) note
{
    return note;
}
@end
