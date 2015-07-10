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
#import "determineDomainUIImageForReturn.h"

// Quick access types...
#define AppDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

@interface domainDetailTableViewController ()

@end

@implementation domainDetailTableViewController

@synthesize posStudentOutlet, negStudentOutlet, posTeacherOutlet, negTeacherOutlet, subdomainTitleOutlet, domainSubtitleOutlet, domainTitleOutlet, domainTitleSubdomainTitleOutlet, compassImageOutlet, negStudentOutletWebView, negTeacherOutletWebView, posStudentOutletWebView, posTeacherOutletWebView;

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
    
    [determineDomainUIImageForReturn alloc];
    [compassImageOutlet setImage:[UIImage imageNamed:[determineDomainUIImageForReturn imageToWrapInImageView:[presentationElements objectForKey:@"domainTitleOutlet"]]]];
    
    // Instantiate the text box style...
    posStudentOutletWebView.layer.borderWidth = 1;
    posStudentOutletWebView.layer.borderColor = posStudentOutletWebView.tintColor.CGColor;
    negTeacherOutletWebView.layer.borderWidth = 1;
    negTeacherOutletWebView.layer.borderColor = negTeacherOutletWebView.tintColor.CGColor;
    negStudentOutletWebView.layer.borderWidth = 1;
    negStudentOutletWebView.layer.borderColor = negStudentOutletWebView.tintColor.CGColor;
    posTeacherOutletWebView.layer.borderWidth = 1;
    posTeacherOutletWebView.layer.borderColor = posTeacherOutletWebView.tintColor.CGColor;
    
    // Initialise some memory
    detailViewData = [[NSMutableDictionary alloc] init];
    
    [abstractionLayer alloc];
    
    // Get the 4 text fields values from the database for this code...
    detailViewData = [abstractionLayer runDictionaryReturnQuery:[NSString stringWithFormat:@"SELECT * FROM `domaindetail` WHERE `domaincode`='%@'", AppDelegate.nextDomain] :[[NSArray alloc] initWithObjects:@"neg_student", @"pos_student", @"neg_teacher", @"pos_teacher", nil]];
    
    [self loadDocument:[detailViewData objectForKey:@"pos_teacher"] inView:posTeacherOutletWebView];
    [self loadDocument:[detailViewData objectForKey:@"pos_student"] inView:posStudentOutletWebView];
    [self loadDocument:[detailViewData objectForKey:@"neg_teacher"] inView:negTeacherOutletWebView];
    [self loadDocument:[detailViewData objectForKey:@"neg_student"] inView:negStudentOutletWebView];
    
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadDocument:(NSString*)documentString inView:(UIWebView*)webView {
    [webView loadHTMLString:documentString baseURL:nil];
}

@end
