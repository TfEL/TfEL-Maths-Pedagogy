//
//  sqlAdminTableViewController.h
//  TfEL Maths Pedagogy
//
//  Created by Aidan Cornelius-Bell on 3/06/2015.
//  Copyright (c) 2015 Department for Education and Child Development. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FMDB.h"

@interface sqlAdminTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *probeStatus;
@property (weak, nonatomic) IBOutlet UITextField *nextQuery;
@property (weak, nonatomic) IBOutlet UITextView *resultQuery;

- (IBAction)runNextQuery:(id)sender;

@end
