//
//  nextStepsTableViewController.m
//  TfEL Maths Pedagogy
//
//  Created by Aidan Cornelius-Bell on 12/06/2015.
//  Copyright (c) 2015 Department for Education and Child Development. All rights reserved.
//

#import "nextStepsTableViewController.h"
#import "AppDelegate.h"
#import "abstractionLayer.h"
#import "getDataByCode.h"
#import "determineDomainUIImageForReturn.h"

// Quick access types...
#define AppDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

@interface nextStepsTableViewController ()

@end

@implementation nextStepsTableViewController

@synthesize subdomainTitleOutlet, domainSubtitleOutlet, domainTitleOutlet, domainTitleSubdomainTitleOutlet, compassImageOutlet, blueButtonOutlet, greenButtonOutlet, redButtonOutlet, yellowButtonOutlet, blueImageOutlet, greenImageOutlet, redImageOutlet, yellowImageOutlet;


NSString *bluePage;
NSString *greenPage;
NSString *redPage;
NSString *yellowPage;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Setup the view
    [getDataByCode alloc];
    NSMutableDictionary *presentationElements = [[NSMutableDictionary alloc] init];
    presentationElements = [getDataByCode getPresentationElementsFor:AppDelegate.nextDomain :@"Next Steps:"];
    
    domainTitleOutlet.text = [presentationElements objectForKey:@"domainTitleOutlet"];
    domainSubtitleOutlet.text = [presentationElements objectForKey:@"domainSubtitleOutlet"];
    subdomainTitleOutlet.text = [presentationElements objectForKey:@"subdomainTitleOutlet"];
    domainTitleSubdomainTitleOutlet.text = [presentationElements objectForKey:@"domainTitleSubdomainTitleOutlet"];
    
    [determineDomainUIImageForReturn alloc];
    [compassImageOutlet setImage:[UIImage imageNamed:[determineDomainUIImageForReturn imageToWrapInImageView:[presentationElements objectForKey:@"domainTitleOutlet"]]]];
    
    blueButtonOutlet.enabled = NO; greenButtonOutlet.enabled = NO; redButtonOutlet.enabled = NO; yellowButtonOutlet.enabled = NO;
    [blueButtonOutlet setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [greenButtonOutlet setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [redButtonOutlet setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [yellowButtonOutlet setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    UIColor *enabledColor = [UIColor colorWithRed:85.0/255.0 green:94.0/255.0 blue:168.0/255.0 alpha:1];
    
    AppDelegate.databasePath = [[NSBundle mainBundle] pathForResource:@"tfelmped" ofType:@"sqlite"];
    FMDatabase* db = [FMDatabase databaseWithPath:AppDelegate.databasePath];
    
    if (![db open]) {
        NSLog(@"TfEL Maths: Database Establishment Failed");
    } else {
        FMResultSet *s = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM \"domainnext\" WHERE `domaincode` = '%@'", AppDelegate.nextDomain]];
        while ([s next]) {
            if ([s boolForColumn:@"blue"] == TRUE) {
                blueButtonOutlet.enabled = YES;
                [blueButtonOutlet setTitleColor:enabledColor forState:UIControlStateNormal];
                bluePage = [s stringForColumn:@"blue_pdf"];
                NSLog(@"Blue Page for %@, %@.", AppDelegate.nextDomain, bluePage);
            } if ([s boolForColumn:@"green"] == TRUE) {
                greenButtonOutlet.enabled = YES;
                [greenButtonOutlet setTitleColor:enabledColor forState:UIControlStateNormal];
                greenPage = [s stringForColumn:@"green_pdf"];
                NSLog(@"Green Page for %@, %@.", AppDelegate.nextDomain, greenPage);
            } if ([s boolForColumn:@"red"] == TRUE) {
                redButtonOutlet.enabled = YES;
                [redButtonOutlet setTitleColor:enabledColor forState:UIControlStateNormal];
                redPage = [s stringForColumn:@"red_pdf"];
                NSLog(@"Red Page for %@, %@.", AppDelegate.nextDomain, redPage);
            } if ([s boolForColumn:@"yellow"] == TRUE) {
                yellowButtonOutlet.enabled = YES;
                [yellowButtonOutlet setTitleColor:enabledColor forState:UIControlStateNormal];
                yellowPage = [s stringForColumn:@"yellow_pdf"];
                NSLog(@"Yellow Page for %@, %@.", AppDelegate.nextDomain, yellowPage);
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (IBAction)transformingTasksOne:(id)sender {
    NSLog(@"%@", bluePage);
    AppDelegate.nextPDFView = bluePage;
    [self jumpToResourceView];
}

- (IBAction)transformingTasksTwo:(id)sender {
    AppDelegate.nextPDFView = greenPage;
    [self jumpToResourceView];
}

- (IBAction)transformingTasksThree:(id)sender {
    AppDelegate.nextPDFView = redPage;
    [self jumpToResourceView];
}

- (IBAction)transformingTasksFour:(id)sender {
    AppDelegate.nextPDFView = yellowPage;
    [self jumpToResourceView];
}

- (IBAction)frameworkGuideOne:(id)sender {
    // Set up the resource view for Framework Guide reference at page 1.
    AppDelegate.nextPDFPage = 1;
    AppDelegate.nextPDFView = [NSString stringWithFormat:@"%@_fg", AppDelegate.nextDomain];
    [self jumpToResourceView];
}

- (void) jumpToResourceView {
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"resourceView"];
    [self showViewController:vc sender:self];
}

- (IBAction)goToLeadingLearning:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.acleadersresource.sa.edu.au/features/transforming-tasks/index.html"]];
}
@end
