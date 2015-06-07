//
//  NotesViewController.m
//  NoteToSelf_cdilly
//
//  Created by A Student on 6/8/14.
//  Copyright (c) 2014 msse650. All rights reserved.
//

#import "NotesViewController.h"
#import "Note.h"
#import "NoteSvcCache.h"
#import "NoteSvcArchive.h"
#import "NoteSvcSQLite.h"

@interface NotesViewController ()

@end

@implementation NotesViewController

NoteSvcCache *noteSvcCache = nil;
NoteSvcArchive *noteSvcArchive = nil;
NoteSvcSQLite *noteSvcLite = nil;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    noteSvcCache = [[NoteSvcCache alloc] init];
    noteSvcArchive = [[NoteSvcArchive alloc] init];
    noteSvcLite = [[NoteSvcSQLite alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Return the number of notes
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[noteSvcCache retrieveAllNotes] count];
}

// Return the table cell for a paricular row (index)
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:simpleTableIdentifier];
    }
    
    Note *note = [[noteSvcCache retrieveAllNotes]
                        objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [note description];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    
    return cell;
}

// Save Note
- (IBAction)saveNote:(id)sender {
    NSLog(@"saveNote: entering");
    
    [self.view endEditing:YES];
    
    Note *note = [[Note alloc] init];
    note.noteText = _noteText.text;
    [noteSvcCache createNote:note];
    
    [self.tableView reloadData];
    NSLog(@"saveNote: note saved");
}

- (IBAction)updateNote:(id)sender {
    NSLog(@"updateNote");
    
    [self.view endEditing:YES];
}
@end
