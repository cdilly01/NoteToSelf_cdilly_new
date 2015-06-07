//
//  NoteSvcSQLite.m
//  NoteToSelf_cdilly
//
//  Created by A Student on 6/8/14.
//  Copyright (c) 2014 msse650. All rights reserved.
//

#import "NoteSvcSQLite.h"
#import <sqlite3.h>

@implementation NoteSvcSQLite

NSString *databasePath = nil;
sqlite3 *database = nil;
NSMutableArray *notes = nil;

-(id) init {
    if ((self = [super init])) {
        
        // Find document directory
        NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docsDir = [dirPaths objectAtIndex:0];
        
        // Append file name
        databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent:@"note.sqlite3"]];

        // open the database (it will be created if it does not exist)
        if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
            NSLog(@"database is open");
            NSLog(@"database file path: %@", databasePath);
            
            NSString *createSql =
            @"CREATE TABLE IF NOT EXISTS contact (id INTEGER PRIMARY KEY AUTOINCREMENT, note VARCHAR(30))";
            char *errMsg;
            if (sqlite3_exec(database, [createSql UTF8String], NULL, NULL, &errMsg) != SQLITE_OK) {
                NSLog(@"Failed to create table %s", errMsg);
            }
            
        } else {
            NSLog(@"*** Failed to open database!");
            NSLog(@"*** SQL error: %s\n", sqlite3_errmsg(database));
        }
    }
    return self;
}

- (void)dealloc {
    sqlite3_close(database);
}

- (Note *) createNote: (Note *) note {
    sqlite3_stmt *statement;
    NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO note (note) VALUES (\"%@\")", note.noteText ];
    if (sqlite3_prepare_v2(database, [insertSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
        if (sqlite3_step(statement) == SQLITE_DONE) {
            note.id = sqlite3_last_insert_rowid(database);
            NSLog(@"*** Note added");
        } else {
            NSLog(@"*** Note NOT added");
            NSLog(@"*** SQL error: %s\n", sqlite3_errmsg(database));
        }
        sqlite3_finalize(statement);
        }
    return note;
    }


- (NSMutableArray *) retrieveAllNotes {
    NSMutableArray *notes = [NSMutableArray array];
    NSString *selectSQL = [NSString stringWithFormat:@"SELECT * FROM note ORDER BY name"];
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, [selectSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
        NSLog(@"*** Notes retrieved");
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int id = sqlite3_column_int(statement, 0);
            char *nameChars = (char *)sqlite3_column_text(statement, 1);
            
            Note *note = [[Note alloc] init];
            note.id = id;
            note.noteText = [[NSString alloc] initWithUTF8String:nameChars];
            [notes addObject:note];
        }
        sqlite3_finalize(statement);
    } else {
        NSLog(@"*** Notes NOT retrieved");
        NSLog(@"*** SQL error: %s\n", sqlite3_errmsg(database));
    }
    
    return notes;
}
- (Note *) updateNote: (Note *) note {
    NSString *updateSQL = [NSString stringWithFormat: @"UPDATE note SET name=\"%@\" WHERE id = %i ", note.noteText, note.id];
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, [updateSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
        if (sqlite3_step(statement) == SQLITE_DONE) {
            NSLog(@"*** Note updated");
        } else {
            NSLog(@"*** Note NOT updated");
            NSLog(@"*** SQL error: %s\n", sqlite3_errmsg(database));
        }
        sqlite3_finalize(statement);
    }

    return note;
}
- (Note *) deleteNOte: (Note *) note {
    NSString *deleteSQL = [NSString stringWithFormat: @"DELETE FROM note WHERE id = %i ", note.id];
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, [deleteSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
        if (sqlite3_step(statement) == SQLITE_DONE) {
            NSLog(@"*** Note deleted");
        } else {
            NSLog(@"*** Note NOT deleted");
            NSLog(@"*** SQL error: %s\n", sqlite3_errmsg(database));
        }
        sqlite3_finalize(statement);
    }
    return note;
}
@end
