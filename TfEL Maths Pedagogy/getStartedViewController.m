//
//  getStartedViewController.m
//  TfEL Maths Pedagogy
//
//  Created by Aidan Cornelius-Bell on 22/05/2015.
//  Copyright (c) 2015 Department for Education and Child Development. All rights reserved.
//

#import "getStartedViewController.h"
#import "abstractionLayer.h"
#import "AppDelegate.h"

// Quick access types...
#define AppDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

@interface getStartedViewController ()

@end

@implementation getStartedViewController

@synthesize getStartedButton, createAccountButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    getStartedButton.layer.cornerRadius = 3;
    getStartedButton.layer.borderWidth = 1;
    getStartedButton.layer.borderColor = getStartedButton.tintColor.CGColor;
    
    createAccountButton.layer.cornerRadius = 3;
    createAccountButton.layer.borderWidth = 1;
    createAccountButton.layer.borderColor = getStartedButton.tintColor.CGColor;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"beta"];
    
    UIPopoverController *popup = [[UIPopoverController alloc] initWithContentViewController:controller];
    
    [popup presentPopoverFromRect:CGRectMake(0, 0, 600, 600) inView:self.view permittedArrowDirections:0 animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [abstractionLayer alloc];
    
    NSMutableDictionary *userData = [abstractionLayer runDictionaryReturnQueryUser:@"SELECT * FROM `userdata`" : [NSArray arrayWithObjects:@"key", @"value", nil]];
    
    if ([[userData valueForKey:@"value"] length] >= 1) {
        [getStartedButton setTitle:[NSString stringWithFormat:@"Continue as %@ »", [userData valueForKey:@"value"]] forState:UIControlStateNormal];
        AppDelegate.cdcName = [userData valueForKey:@"value"];
        AppDelegate.userFullName = [userData valueForKey:@"value"];
        getStartedButton.hidden = NO;
        createAccountButton.hidden = YES;
    } else {
        if ([AppDelegate.cdcName length] >= 1) {
            [getStartedButton setTitle:[NSString stringWithFormat:@"Continue as %@ »", AppDelegate.cdcName] forState:UIControlStateNormal];
            getStartedButton.hidden = NO;
            
            AppDelegate.userFullName = AppDelegate.cdcName;
        } else {
            getStartedButton.hidden = YES;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
