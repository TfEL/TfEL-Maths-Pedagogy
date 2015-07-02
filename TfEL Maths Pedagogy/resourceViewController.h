//
//  resourceViewController.h
//  TfEL Maths Pedagogy
//
//  Created by Aidan Cornelius-Bell on 24/06/2015.
//  Copyright (c) 2015 Department for Education and Child Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface resourceViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

- (IBAction)shareButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *shareButtonRef;

@end
