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

@interface NotesViewController ()

@end

@implementation NotesViewController

NoteSvcCache *noteSvcCache = nil;

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
- (IBAction)addNote:(id)sender {
    [self.view endEditing:YES];
    
    // get array of notes
    NSMutableArray *notes = [noteSvcCache retrieveAllNotes];
    
    // instantiate new note with sender note
    Note *note = [[Note alloc] init];
    note.noteText = _noteInputText.text;
    
    // find index...
    NSUInteger index = [notes indexOfObject: note ];
    
    // add note if doesn't exist
    if (index == NSNotFound){
        NSLog(@"saveNote: adding new note");
        [noteSvcCache createNote:note];
    }
    else{
        // if note exists, delete then add
        [notes removeObjectAtIndex: index];
        NSLog(@"deleteNote: note deleted");
        
        // now add...
        NSLog(@"saveNote: adding new note");
    }
    
    [self.tableView reloadData];
    NSLog(@"saveNote: note saved");
}

- (IBAction)deleteNote:(id)sender {
    NSLog(@"deleteNote");
    
    // get array of notes
    NSMutableArray *notes = [noteSvcCache retrieveAllNotes];
    
    // instantiate new note with sender note
    Note *note = [[Note alloc] init];
    note.noteText = _noteInputText.text;
    NSUInteger index = [notes indexOfObject: note ];
    
    if (index != NSNotFound){
        [notes removeObjectAtIndex: index];
        [self.tableView reloadData];
        NSLog(@"deleteNote: note deleted");
    }
}
@end
