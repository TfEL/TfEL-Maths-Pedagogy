//
//  dropMenuTableViewController.h
//  TfEL Maths Pedagogy
//
//  Created by Aidan Cornelius-Bell on 25/06/2015.
//  Copyright (c) 2015 Department for Education and Child Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface dropMenuTableViewController : UITableViewController

- (IBAction)versionButton:(id)sender;

@property (weak, nonatomic) IBOutlet UITableViewCell *adminButton;

@end
