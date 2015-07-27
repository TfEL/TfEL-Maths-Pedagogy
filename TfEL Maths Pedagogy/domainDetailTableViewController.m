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

@synthesize subdomainTitleOutlet, domainSubtitleOutlet, domainTitleOutlet, domainTitleSubdomainTitleOutlet, compassImageOutlet, negStudentOutletWebView, negTeacherOutletWebView, posStudentOutletWebView, posTeacherOutletWebView;

NSMutableDictionary *detailViewData;

NSData *posStuViewObj;
NSData *posTeaViewObj;
NSData *negStuViewObj;
NSData *negTeaViewObj;


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
    
    posStuViewObj = [posStudentOutletWebView valueForKey:@"layer"];
    posTeaViewObj = [posTeacherOutletWebView valueForKey:@"layer"];
    negStuViewObj = [negStudentOutletWebView valueForKey:@"layer"];
    negTeaViewObj = [negTeacherOutletWebView valueForKey:@"layer"];
    
    [posStudentOutletWebView addObserver:self forKeyPath:@"scrollView.contentOffset" options:NSKeyValueObservingOptionNew context:NULL];
    [negStudentOutletWebView addObserver:self forKeyPath:@"scrollView.contentOffset" options:NSKeyValueObservingOptionNew context:NULL];
    [posTeacherOutletWebView addObserver:self forKeyPath:@"scrollView.contentOffset" options:NSKeyValueObservingOptionNew context:NULL];
    [negTeacherOutletWebView addObserver:self forKeyPath:@"scrollView.contentOffset" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([object isKindOfClass:[UIWebView class]]
       && [keyPath isEqualToString:@"scrollView.contentOffset"]) {
        
        static BOOL isChanging = NO;
        
        CGPoint offset = [[change valueForKey:NSKeyValueChangeNewKey] CGPointValue];
        
        if ([object valueForKey:@"layer"] == posStuViewObj && !CGPointEqualToPoint(offset, CGPointZero) && isChanging == NO) {
            isChanging = YES;
            negStudentOutletWebView.scrollView.contentOffset = offset;
            isChanging = NO;
        }
        if ([object valueForKey:@"layer"] == negStuViewObj && !CGPointEqualToPoint(offset, CGPointZero) && isChanging == NO) {
            isChanging = YES;
            posStudentOutletWebView.scrollView.contentOffset = offset;
            isChanging = NO;
        }
        
        if ([object valueForKey:@"layer"] == posTeaViewObj && !CGPointEqualToPoint(offset, CGPointZero) && isChanging == NO) {
            isChanging = YES;
            negTeacherOutletWebView.scrollView.contentOffset = offset;
            isChanging = NO;
        }
        if ([object valueForKey:@"layer"] == negTeaViewObj && !CGPointEqualToPoint(offset, CGPointZero) && isChanging == NO) {
            isChanging = YES;
            posTeacherOutletWebView.scrollView.contentOffset = offset;
            isChanging = NO;
        }
    }
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [posStudentOutletWebView removeObserver:self forKeyPath:@"scrollView.contentOffset"];
    [negStudentOutletWebView removeObserver:self forKeyPath:@"scrollView.contentOffset"];
    [posTeacherOutletWebView removeObserver:self forKeyPath:@"scrollView.contentOffset"];
    [negTeacherOutletWebView removeObserver:self forKeyPath:@"scrollView.contentOffset"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    [posStudentOutletWebView removeObserver:self forKeyPath:@"scrollView.contentOffset"];
    [negStudentOutletWebView removeObserver:self forKeyPath:@"scrollView.contentOffset"];
    [posTeacherOutletWebView removeObserver:self forKeyPath:@"scrollView.contentOffset"];
    [negTeacherOutletWebView removeObserver:self forKeyPath:@"scrollView.contentOffset"];
}

-(void)loadDocument:(NSString*)documentString inView:(UIWebView*)webView {
    [webView loadHTMLString:documentString baseURL:nil];
}

@end
