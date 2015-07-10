//
//  domainDetailTableViewController.h
//  TfEL Maths Pedagogy
//
//  Created by Aidan Cornelius-Bell on 12/06/2015.
//  Copyright (c) 2015 Department for Education and Child Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface domainDetailTableViewController : UITableViewController <UIWebViewDelegate>

// Domain setup outlets
@property (weak, nonatomic) IBOutlet UIImageView *compassImageOutlet;
@property (weak, nonatomic) IBOutlet UILabel *domainTitleOutlet;
@property (weak, nonatomic) IBOutlet UILabel *domainSubtitleOutlet;
@property (weak, nonatomic) IBOutlet UILabel *subdomainTitleOutlet;
@property (weak, nonatomic) IBOutlet UILabel *domainTitleSubdomainTitleOutlet;

// Text area outlets
@property (weak, nonatomic) IBOutlet UITextView *negStudentOutlet;
@property (weak, nonatomic) IBOutlet UITextView *negTeacherOutlet;
@property (weak, nonatomic) IBOutlet UITextView *posStudentOutlet;
@property (weak, nonatomic) IBOutlet UITextView *posTeacherOutlet;

@property (weak, nonatomic) IBOutlet UIWebView *negStudentOutletWebView;
@property (weak, nonatomic) IBOutlet UIWebView *negTeacherOutletWebView;
@property (weak, nonatomic) IBOutlet UIWebView *posStudentOutletWebView;
@property (weak, nonatomic) IBOutlet UIWebView *posTeacherOutletWebView;

@end
