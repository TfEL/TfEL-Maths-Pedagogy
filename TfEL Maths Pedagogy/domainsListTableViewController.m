//
//  domainsListTableViewController.m
//  TfEL Maths Pedagogy
//
//  Created by Aidan Cornelius-Bell on 27/05/2015.
//  Copyright (c) 2015 Department for Education and Child Development. All rights reserved.
//

#import "domainsListTableViewController.h"

#import "AppDelegate.h"

#define AppDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

@interface domainsListTableViewController ()

@end

@implementation domainsListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)twoPointOne:(id)sender {
    // This is the SQL `domaincode` match...
    AppDelegate.nextDomain = @"2.1";
}

- (IBAction)threePointOne:(id)sender {
    // This is the SQL `domaincode` match...
    AppDelegate.nextDomain = @"3.1";
}

- (IBAction)fourPointOne:(id)sender {
    // This is the SQL `domaincode` match...
    AppDelegate.nextDomain = @"4.1";
}

- (IBAction)twoPointTwo:(id)sender {
    // This is the SQL `domaincode` match...
    AppDelegate.nextDomain = @"2.2";
}

- (IBAction)threePointTwo:(id)sender {
    // This is the SQL `domaincode` match...
    AppDelegate.nextDomain = @"3.2";
}

- (IBAction)fourPointTwo:(id)sender {
    // This is the SQL `domaincode` match...
    AppDelegate.nextDomain = @"4.2";
}

- (IBAction)twoPointThree:(id)sender {
    // This is the SQL `domaincode` match...
    AppDelegate.nextDomain = @"2.3";
}

- (IBAction)threePointThree:(id)sender {
    // This is the SQL `domaincode` match...
    AppDelegate.nextDomain = @"3.3";
}

- (IBAction)fourPointThree:(id)sender {
    // This is the SQL `domaincode` match...
    AppDelegate.nextDomain = @"4.3";
}

- (IBAction)twoPointFour:(id)sender {
    // This is the SQL `domaincode` match...
    AppDelegate.nextDomain = @"2.4";
}

- (IBAction)threePointFour:(id)sender {
    // This is the SQL `domaincode` match...
    AppDelegate.nextDomain = @"3.4";
}

- (IBAction)fourPointFour:(id)sender {
    // This is the SQL `domaincode` match...
    AppDelegate.nextDomain = @"4.4";
}
@end
