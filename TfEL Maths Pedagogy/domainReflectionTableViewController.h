//
//  domainReflectionTableViewController.h
//  TfEL Maths Pedagogy
//
//  Created by Aidan Cornelius-Bell on 3/06/2015.
//  Copyright (c) 2015 Department for Education and Child Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZTextView.h"

@interface domainReflectionTableViewController : UITableViewController

// Button Groups
@property (weak, nonatomic) IBOutlet UIButton *nydWhatMight;
@property (weak, nonatomic) IBOutlet UIButton *iwdWhatMight;
@property (weak, nonatomic) IBOutlet UIButton *nextSteps;
@property (weak, nonatomic) IBOutlet UIButton *myPastEntries;

// Text Box Groups
@property (weak, nonatomic) IBOutlet SZTextView *nydTextOutlet;
@property (weak, nonatomic) IBOutlet SZTextView *iwdTextOutlet;

// Headers from DB OBJ
@property (weak, nonatomic) IBOutlet UILabel *domainTitle;
@property (weak, nonatomic) IBOutlet UILabel *domainSubtitle;
@property (weak, nonatomic) IBOutlet UILabel *subdomaintitle;
@property (weak, nonatomic) IBOutlet UILabel *subdomainGuidingQuestions;
@property (weak, nonatomic) IBOutlet UITextView *subdomainBody;

@property (weak, nonatomic) IBOutlet UISlider *sliderOutlet;

@end
