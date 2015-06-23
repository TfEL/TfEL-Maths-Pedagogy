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

@end
