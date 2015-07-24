//
//  ViewController.m
//  TextMutationTests
//
//  Created by Aidan Cornelius-Bell on 24/07/2015.
//  Copyright (c) 2015 Department for Education and Child Development. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize textView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSAttributedString *textViewValue = textView.attributedText;
    NSLog(@"%@", textViewValue);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *settingsPlistPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"settings.plist"];
    
    NSMutableArray *arr = [[NSMutableArray alloc] initWithContentsOfFile:settingsPlistPath];
    
    textView.attributedText = [arr objectAtIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
