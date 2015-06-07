//
//  NoteSvcCache.m
//  NoteToSelf_cdilly
//
//  Created by A Student on 6/8/14.
//  Copyright (c) 2014 msse650. All rights reserved.
//

#import "NoteSvcCache.h"

@implementation NoteSvcCache

NSMutableArray *notes = nil;

- (id) init {
    if (self = [super init]) {
        notes = [NSMutableArray array];
        return self;
    }
    return nil;
}

- (Note *) createNote: (Note *) note {
    [notes addObject: note];
    return note;
}

- (NSMutableArray *) retrieveAllNotes {
    return notes;
}

- (Note *) deleteNote: (Note *) note {
    [notes removeObject: note];
    return note;
}

@end
