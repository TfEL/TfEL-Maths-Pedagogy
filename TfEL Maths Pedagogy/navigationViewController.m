//
//  navigationViewController.m
//  TfEL Maths Pedagogy
//
//  Created by Aidan Cornelius-Bell on 22/05/2015.
//  Copyright (c) 2015 Department for Education and Child Development. All rights reserved.
//

#import "navigationViewController.h"

@interface navigationViewController ()

@end

@implementation navigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Setup for OfE header...
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage imageNamed:@"OE_Header.png"]
                         resizableImageWithCapInsets:UIEdgeInsetsMake(0, 190, 190, 0)
                                        resizingMode:UIImageResizingModeStretch] forBarMetrics:UIBarMetricsDefault];
    
    
    // Remove static line underneath header...
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    
    // Disable translucency...
    [self.navigationBar setTranslucent:NO ];
    
    // Hackily dispose of the title
    self.navigationBar.topItem.title = @"";
    
    // Shift the title to the right
    CGFloat verticalOffset = -6;
    [[UINavigationBar appearance] setTitleVerticalPositionAdjustment:verticalOffset forBarMetrics:UIBarMetricsDefault];
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
