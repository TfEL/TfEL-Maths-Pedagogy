//
//  getStartedViewController.m
//  TfEL Maths Pedagogy
//
//  Created by Aidan Cornelius-Bell on 22/05/2015.
//  Copyright (c) 2015 Department for Education and Child Development. All rights reserved.
//

#import "getStartedViewController.h"

@interface getStartedViewController ()

@end

@implementation getStartedViewController

@synthesize getStartedButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    getStartedButton.layer.cornerRadius = 3;
    getStartedButton.layer.borderWidth = 1;
    getStartedButton.layer.borderColor = getStartedButton.tintColor.CGColor;
    
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
