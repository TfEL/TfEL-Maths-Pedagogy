//
//  domainsListTableViewController.h
//  TfEL Maths Pedagogy
//
//  Created by Aidan Cornelius-Bell on 27/05/2015.
//  Copyright (c) 2015 Department for Education and Child Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface domainsListTableViewController : UITableViewController

- (IBAction)twoPointOne:(id)sender;
- (IBAction)threePointOne:(id)sender;
- (IBAction)fourPointOne:(id)sender;

- (IBAction)twoPointTwo:(id)sender;
- (IBAction)threePointTwo:(id)sender;
- (IBAction)fourPointTwo:(id)sender;

- (IBAction)twoPointThree:(id)sender;
- (IBAction)threePointThree:(id)sender;
- (IBAction)fourPointThree:(id)sender;

- (IBAction)twoPointFour:(id)sender;
- (IBAction)threePointFour:(id)sender;
- (IBAction)fourPointFour:(id)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *nameRef;

@end
