//
//  settingsTableViewController.h
//  TextMutationTests
//
//  Created by Aidan Cornelius-Bell on 24/07/2015.
//  Copyright (c) 2015 Department for Education and Child Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface settingsTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *stringValue;
@property (weak, nonatomic) IBOutlet UITextField *htmlValue;

- (IBAction)saveButton:(id)sender;

@end
