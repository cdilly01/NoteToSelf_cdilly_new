//
//  NoteSvc.h
//  NoteToSelf_cdilly
//
//  Created by A Student on 6/8/14.
//  Copyright (c) 2014 msse650. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Note.h"

@protocol NoteSvc <NSObject>

- (Note *) createNote: (Note *) note;
- (NSMutableArray *) retrieveAllNotes;
- (Note *) updateNote: (Note *) note;
- (Note *) deleteNote: (Note *) note;

@end
