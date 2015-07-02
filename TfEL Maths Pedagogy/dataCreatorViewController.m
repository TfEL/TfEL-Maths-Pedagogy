//
//  dataCreatorViewController.m
//  TfEL Maths Pedagogy
//
//  Created by Aidan Cornelius-Bell on 12/06/2015.
//  Copyright (c) 2015 Department for Education and Child Development. All rights reserved.
//

#import "dataCreatorViewController.h"
#import "abstractionLayer.h"
#import "AppDelegate.h"

// Quick access types...
#define AppDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

@interface dataCreatorViewController ()

@end

@implementation dataCreatorViewController

@synthesize dataNameOutlet, dataOriginOutlet, createUserButtonOutlet;

NSFileManager *fileManager;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    createUserButtonOutlet.layer.cornerRadius = 3;
    createUserButtonOutlet.layer.borderWidth = 1;
    createUserButtonOutlet.layer.borderColor = createUserButtonOutlet.tintColor.CGColor;
    
    [dataNameOutlet becomeFirstResponder];
    
    dataOriginOutlet.text = @"tfeluserdata.sqlite";
    dataOriginOutlet.enabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)createUserButton:(id)sender {
    NSLog(@"TfEL Maths: copying %@ to %@/.", [[NSBundle mainBundle] pathForResource:@"tfeluserdata" ofType:@"sqlite"], [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]);
    
    [[[UIAlertView alloc] initWithTitle:@"Create Account" message:[NSString stringWithFormat:@"You have entered your name as %@. If you're ready, let's get started.", dataNameOutlet.text] delegate:self cancelButtonTitle:@"Create Account" otherButtonTitles:@"Cancel", nil] show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        AppDelegate.cdcName = dataNameOutlet.text;
        
        if ([self copyFolderAtPath: [[NSBundle mainBundle] pathForResource:@"tfeluserdata" ofType:@"sqlite"]
         toDestinationFolderAtPath: [NSString stringWithFormat:@"%@/", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]]]) {
            createUserButtonOutlet.enabled = NO;
            [dataNameOutlet resignFirstResponder];
            
            [abstractionLayer alloc];
            
            if ([abstractionLayer runBoolReturnQuery:[NSString stringWithFormat:@"INSERT INTO \"userdata\" (\"id\",\"key\",\"value\") VALUES (NULL,'username','%@')", [dataNameOutlet.text capitalizedString]]]) {
                // Jump!
                AppDelegate.cdcName = dataNameOutlet.text;
                AppDelegate.userFullName = dataNameOutlet.text;
                UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"homeScreen"];
                [self presentViewController:vc animated:YES completion:^{}];
            } else {
                NSLog(@"TfEL Maths: Couldn't update user database");
            }
            
        } else {
            NSLog(@"TfEL Maths: Failed to copy empty dataset.");
        }
    }
}

- (BOOL)copyFolderAtPath:(NSString *)sourceFolder toDestinationFolderAtPath:(NSString*)destinationFolder {
    //including root folder.
    //Just remove it if you just want to copy the contents of the source folder.
    destinationFolder = [destinationFolder stringByAppendingPathComponent:[sourceFolder lastPathComponent]];
    
    NSFileManager * fileManager = [ NSFileManager defaultManager];
    NSError * error = nil;
    //check if destinationFolder exists
    if ([ fileManager fileExistsAtPath:destinationFolder])
    {
        //removing destination, so soucer may be copied
        if (![fileManager removeItemAtPath:destinationFolder error:&error])
        {
            NSLog(@"Could not remove old files. Error:%@",error);
            return NO;
        }
    }
    error = nil;
    //copying destination
    if ( !( [ fileManager copyItemAtPath:sourceFolder toPath:destinationFolder error:&error ]) )
    {
        NSLog(@"Could not copy report at path %@ to path %@. error %@",sourceFolder, destinationFolder, error);
        return NO;
    }
    return YES;
}

@end
