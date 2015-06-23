//
//  dataCreatorViewController.h
//  TfEL Maths Pedagogy
//
//  Created by Aidan Cornelius-Bell on 12/06/2015.
//  Copyright (c) 2015 Department for Education and Child Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface dataCreatorViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *dataNameOutlet;
@property (weak, nonatomic) IBOutlet UITextField *dataOriginOutlet;
@property (weak, nonatomic) IBOutlet UIButton *createUserButtonOutlet;

- (IBAction)createUserButton:(id)sender;

@end
