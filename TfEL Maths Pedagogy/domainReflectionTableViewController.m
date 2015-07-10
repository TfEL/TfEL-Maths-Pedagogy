//
//  domainReflectionTableViewController.m
//  TfEL Maths Pedagogy
//
//  Created by Aidan Cornelius-Bell on 3/06/2015.
//  Copyright (c) 2015 Department for Education and Child Development. All rights reserved.
//

#import "domainReflectionTableViewController.h"
#import "AppDelegate.h"
#import "FMDatabase.h"
#import "abstractionLayer.h"
#import "determineDomainUIImageForReturn.h"

#import "determineDetailForCode.h"

// Quick access types...
#define AppDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

@interface domainReflectionTableViewController ()

@end

@implementation domainReflectionTableViewController

@synthesize nydWhatMight, iwdWhatMight, nextSteps, myPastEntries, nydTextOutlet, iwdTextOutlet, domainTitle, domainSubtitle, subdomainBody, subdomainGuidingQuestions, subdomaintitle, sliderOutlet, domainImage;

// Some public variables
NSString *nextQuery;
NSMutableDictionary *viewData;
NSMutableDictionary *userData;
bool shouldPopulateNydIwd;

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // Let's build a query, Obj-C is lovely in this way, where we can scaffold queries with actual data types...
    
    // Determine to present a default (clean) view, or the users reflection
    // Using domaincode to create a clean state
    [determineDetailForCode alloc];
    NSMutableDictionary *userData = [[NSMutableDictionary alloc] init];
    if (AppDelegate.nvShouldRetrFromUserEntries == YES) {
        // Users reflection, needs to get some extra data for this view.
        // Extra data
        nextQuery = [NSString stringWithFormat:@"SELECT * FROM 'userentries' WHERE `id`='%@'", AppDelegate.idForUserData];
        shouldPopulateNydIwd = YES;
        NSString *databasePath = [NSString stringWithFormat:@"%@/tfeluserdata.sqlite", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]];
        // Database to get user data
        FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
        
        // Query runner to get user data..
        if (![db open]) {
            [self dataInconsistency:@"No database connection."];
        } else {
            FMResultSet *s = [db executeQuery:nextQuery];
            while ([s next]) {
                AppDelegate.nextDomain = [s objectForColumnName:@"domaincode"];
                [userData setValue:[s objectForColumnName:@"neg_notes"] forKey:@"notYet"];
                [userData setValue:[s objectForColumnName:@"pos_notes"] forKey:@"wellDev"];
                [userData setObject:[s objectForKeyedSubscript:@"slider_val"] forKey:@"sliderValue"];
                [userData setObject:[NSNumber numberWithBool:YES] forKey:@"hasUserData"];
            }
        }
    }
    NSMutableDictionary *domainDetailForCode = [determineDetailForCode domainDetailForCode:AppDelegate.nextDomain];
    [self populateViewWithData:domainDetailForCode : userData];
}

- (void) populateViewWithData: (NSMutableDictionary *)dataToUse :(NSMutableDictionary *)userData {
    [determineDomainUIImageForReturn alloc];
    
    // Establish the view data from the database :)
    domainTitle.text = [dataToUse valueForKey:@"domainTitle"];
    domainSubtitle.text = [dataToUse valueForKey:@"domainSubtitle"];
    subdomaintitle.text = [dataToUse valueForKey:@"subdomainTitle"];
    subdomainBody.text = [dataToUse valueForKey:@"subdomainBody"];
    [domainImage setImage:[UIImage imageNamed:[determineDomainUIImageForReturn imageToWrapInImageView:[dataToUse valueForKey:@"domainTitle"]]]];
    subdomainGuidingQuestions.text = [NSString stringWithFormat:@"%@ %@ - Guiding Questions:", [dataToUse valueForKey:@"code"], [dataToUse valueForKey:@"subdomainTitle"]];
    
    if (shouldPopulateNydIwd == YES) {
        // The person doesn't need to do any more reflection...
        myPastEntries.hidden = YES;
        nextSteps.hidden = YES;
        nydWhatMight.hidden = YES;
        iwdWhatMight.hidden = YES;
        nydTextOutlet.editable = NO;
        iwdTextOutlet.editable = NO;
        sliderOutlet.enabled = NO;
        
        NSLog(@"%@", userData);
        
        nydTextOutlet.text = [userData valueForKey:@"notYet"];
        iwdTextOutlet.text = [userData valueForKey:@"wellDev"];
        
        sliderOutlet.value = [[userData valueForKey:@"sliderValue"] integerValue];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    nydWhatMight.layer.borderWidth = 1;
    nydWhatMight.layer.borderColor = nydWhatMight.tintColor.CGColor;
    
    iwdWhatMight.layer.borderWidth = 1;
    iwdWhatMight.layer.borderColor = iwdWhatMight.tintColor.CGColor;
    
    nextSteps.layer.cornerRadius = 3;
    nextSteps.layer.borderWidth = 1;
    nextSteps.layer.borderColor = nextSteps.tintColor.CGColor;
    
    myPastEntries.layer.cornerRadius = 3;
    myPastEntries.layer.borderWidth = 1;
    myPastEntries.layer.borderColor = myPastEntries.tintColor.CGColor;
    
    
    // Instantiate the LHS text box style...
    nydTextOutlet.layer.borderWidth = 1;
    nydTextOutlet.layer.borderColor = nydTextOutlet.tintColor.CGColor;
    
    nydTextOutlet.placeholder = @"Note student and teacher actions that suggest this elemet is not yet developed...";
    nydTextOutlet.placeholderTextColor = [UIColor lightGrayColor];
    
    
    // Instantiate the RHS text box style...
    iwdTextOutlet.layer.borderWidth = 1;
    iwdTextOutlet.layer.borderColor = iwdTextOutlet.tintColor.CGColor;
    
    iwdTextOutlet.placeholder = @"Note student and teacher actions that suggest that this elemet is well developed...";
    iwdTextOutlet.placeholderTextColor = [UIColor lightGrayColor];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    // Unload the user entries values.
    AppDelegate.nvShouldRetrFromUserEntries = NO;
    shouldPopulateNydIwd = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Now we need to save the values of the text in use
    if (([iwdTextOutlet.text length] >= 2 || [nydTextOutlet.text length] >= 2 ) && shouldPopulateNydIwd == NO  && AppDelegate.nvShouldEnterToUserEntries == YES) {
        static BOOL shouldUpdate = YES;
        
        NSString *saveDataQuery = [NSString stringWithFormat:@"INSERT INTO \"userentries\" (\"id\",\"datemodified\",\"neg_notes\",\"pos_notes\",\"slider_val\",\"domaincode\") VALUES (NULL,time(),'%@','%@','%f', '%@')", nydTextOutlet.text, iwdTextOutlet.text, sliderOutlet.value, [viewData valueForKey:@"code"]];
        
        if (shouldUpdate) {
            [abstractionLayer alloc];
            if ( [abstractionLayer runBoolReturnQuery:saveDataQuery] ) { NSLog(@"TfEL Maths: Added new data"); AppDelegate.nvShouldEnterToUserEntries = NO; }
        }
    } else {
        // Resume, nothing here...
    }
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    NSLog(@"TfEL Maths: TV content is changing, updating AD.");
    AppDelegate.nvShouldEnterToUserEntries = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dataInconsistency: (NSString *)throwReason {
    [NSThread sleepForTimeInterval:2.0f];
    NSLog(@"TfEL Maths Pedagogy Crashed: %@", throwReason);
    @throw NSInternalInconsistencyException;
}


@end
