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

// Quick access types...
#define AppDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

@interface nextStepsTableViewController ()

@end

@implementation nextStepsTableViewController

@synthesize subdomainTitleOutlet, domainSubtitleOutlet, domainTitleOutlet, domainTitleSubdomainTitleOutlet, compassImageOutlet;


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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
