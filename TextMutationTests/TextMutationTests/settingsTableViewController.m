//
//  settingsTableViewController.m
//  TextMutationTests
//
//  Created by Aidan Cornelius-Bell on 24/07/2015.
//  Copyright (c) 2015 Department for Education and Child Development. All rights reserved.
//

#import "settingsTableViewController.h"

@interface settingsTableViewController ()

@end

@implementation settingsTableViewController

@synthesize stringValue, htmlValue;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *settingsPlistPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"settings.plist"];

    NSMutableArray *arr = [[NSMutableArray alloc] initWithContentsOfFile:settingsPlistPath];
    
    stringValue.text = [arr objectAtIndex:0];
    htmlValue.text = [arr objectAtIndex:1];
    
    stringValue.enabled = YES; htmlValue.enabled = YES;
    [stringValue becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveButton:(id)sender {
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *settingsPlistPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"settings.plist"];
    [arr addObject:stringValue.text];
    [arr addObject:htmlValue.text];
    [arr writeToFile:settingsPlistPath atomically:YES];
    [stringValue resignFirstResponder];
    NSLog(@"%@ %@", [arr objectAtIndex:0], [arr objectAtIndex:1]);
    stringValue.enabled = NO; htmlValue.enabled = NO;
}
@end
