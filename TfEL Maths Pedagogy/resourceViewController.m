//
//  resourceViewController.m
//  TfEL Maths Pedagogy
//
//  Created by Aidan Cornelius-Bell on 24/06/2015.
//  Copyright (c) 2015 Department for Education and Child Development. All rights reserved.
//

#import "resourceViewController.h"
#import "AppDelegate.h"

// Quick access types...
#define AppDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

@interface resourceViewController ()

@end

@implementation resourceViewController

@synthesize webView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *nextPDFView = AppDelegate.nextPDFView;
    
    // Do any additional setup after loading the view.
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:nextPDFView ofType:@"pdf"]]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
