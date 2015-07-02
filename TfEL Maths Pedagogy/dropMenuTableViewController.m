
//
//  dropMenuTableViewController.m
//  TfEL Maths Pedagogy
//
//  Created by Aidan Cornelius-Bell on 25/06/2015.
//  Copyright (c) 2015 Department for Education and Child Development. All rights reserved.
//

#import "dropMenuTableViewController.h"

#import "AppDelegate.h"

#define AppDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

@interface dropMenuTableViewController ()

@end

@implementation dropMenuTableViewController

@synthesize adminButton;

int count;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    if (AppDelegate.adminButton == 1) {
        adminButton.hidden = false;
    } else {
        adminButton.hidden = true;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)versionButton:(id)sender {
    count++;
    NSLog(@"TfEL Maths: That tickles. Count: %d.", count);
    // Little bit of trickery so you can get to the admin menu
    if (count >= 4) {
        adminButton.hidden = true;
        AppDelegate.adminButton = 1;
    }
}

@end
