//
//  nextStepsTableViewController.h
//  TfEL Maths Pedagogy
//
//  Created by Aidan Cornelius-Bell on 12/06/2015.
//  Copyright (c) 2015 Department for Education and Child Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface nextStepsTableViewController : UITableViewController

// Domain setup outlets
@property (weak, nonatomic) IBOutlet UIImageView *compassImageOutlet;
@property (weak, nonatomic) IBOutlet UILabel *domainTitleOutlet;
@property (weak, nonatomic) IBOutlet UILabel *domainSubtitleOutlet;
@property (weak, nonatomic) IBOutlet UILabel *subdomainTitleOutlet;
@property (weak, nonatomic) IBOutlet UILabel *domainTitleSubdomainTitleOutlet;

- (IBAction)transformingTasksOne:(id)sender;
- (IBAction)transformingTasksTwo:(id)sender;
- (IBAction)transformingTasksThree:(id)sender;
- (IBAction)transformingTasksFour:(id)sender;
- (IBAction)frameworkGuideOne:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *blueButtonOutlet;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *blueImageOutlet;

@property (weak, nonatomic) IBOutlet UIButton *greenButtonOutlet;
@property (weak, nonatomic) IBOutlet UIImageView *greenImageOutlet;

@property (weak, nonatomic) IBOutlet UIButton *redButtonOutlet;
@property (weak, nonatomic) IBOutlet UIImageView *redImageOutlet;

@property (weak, nonatomic) IBOutlet UIButton *yellowButtonOutlet;
@property (weak, nonatomic) IBOutlet UIImageView *yellowImageOutlet;

@end
