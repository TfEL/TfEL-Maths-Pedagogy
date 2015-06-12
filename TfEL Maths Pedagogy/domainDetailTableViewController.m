//
//  domainDetailTableViewController.m
//  TfEL Maths Pedagogy
//
//  Created by Aidan Cornelius-Bell on 12/06/2015.
//  Copyright (c) 2015 Department for Education and Child Development. All rights reserved.
//

#import "domainDetailTableViewController.h"
#import "AppDelegate.h"
#import "abstractionLayer.h"
#import "getDataByCode.h"

// Quick access types...
#define AppDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

@interface domainDetailTableViewController ()

@end

@implementation domainDetailTableViewController

@synthesize posStudentOutlet, negStudentOutlet, posTeacherOutlet, negTeacherOutlet, subdomainTitleOutlet, domainSubtitleOutlet, domainTitleOutlet, domainTitleSubdomainTitleOutlet, compassImageOutlet;

NSMutableDictionary *detailViewData;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Setup the view
    [getDataByCode alloc];
    NSMutableDictionary *presentationElements = [[NSMutableDictionary alloc] init];
    presentationElements = [getDataByCode getPresentationElementsFor:AppDelegate.nextDomain :@"What might this look like?"];
    
    domainTitleOutlet.text = [presentationElements objectForKey:@"domainTitleOutlet"];
    domainSubtitleOutlet.text = [presentationElements objectForKey:@"domainSubtitleOutlet"];
    subdomainTitleOutlet.text = [presentationElements objectForKey:@"subdomainTitleOutlet"];
    domainTitleSubdomainTitleOutlet.text = [presentationElements objectForKey:@"domainTitleSubdomainTitleOutlet"];
    
    // Initialise some memory
    detailViewData = [[NSMutableDictionary alloc] init];
    
    [abstractionLayer alloc];
    
    // Get the 4 text fields values from the database for this code...
    detailViewData = [abstractionLayer runDictionaryReturnQuery:[NSString stringWithFormat:@"SELECT * FROM `domaindetail` WHERE `domaincode`='%@'", AppDelegate.nextDomain] :[[NSArray alloc] initWithObjects:@"neg_student", @"pos_student", @"neg_teacher", @"pos_teacher", nil]];
    
    posTeacherOutlet.text = [detailViewData objectForKey:@"pos_teacher"];
    posStudentOutlet.text = [detailViewData objectForKey:@"pos_student"];
    negTeacherOutlet.text = [detailViewData objectForKey:@"neg_teacher"];
    negStudentOutlet.text = [detailViewData objectForKey:@"neg_student"];
    
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
