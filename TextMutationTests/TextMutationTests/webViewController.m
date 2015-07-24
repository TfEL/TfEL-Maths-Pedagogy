//
//  webViewController.m
//  TextMutationTests
//
//  Created by Aidan Cornelius-Bell on 24/07/2015.
//  Copyright (c) 2015 Department for Education and Child Development. All rights reserved.
//

#import "webViewController.h"

@interface webViewController ()

@end

@implementation webViewController

@synthesize webView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *settingsPlistPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"settings.plist"];
    
    NSMutableArray *arr = [[NSMutableArray alloc] initWithContentsOfFile:settingsPlistPath];
    
    [webView loadHTMLString:[arr objectAtIndex:1] baseURL:[[NSBundle mainBundle] bundleURL]];
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
