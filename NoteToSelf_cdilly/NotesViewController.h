//
//  NotesViewController.h
//  NoteToSelf_cdilly
//
//  Created by A Student on 6/8/14.
//  Copyright (c) 2014 msse650. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *noteInputText;

- (IBAction)addNote:(id)sender;

- (IBAction)updateNote:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end
