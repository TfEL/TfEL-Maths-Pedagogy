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

// Quick access types...
#define AppDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

@interface domainReflectionTableViewController ()

@end

@implementation domainReflectionTableViewController

@synthesize nydWhatMight, iwdWhatMight, nextSteps, myPastEntries, nydTextOutlet, iwdTextOutlet, domainTitle, domainSubtitle, subdomainBody, subdomainGuidingQuestions, subdomaintitle, sliderOutlet, domainImage;

// Some public variables
NSString *nextQuery;
NSMutableDictionary *viewData;
bool shouldPopulateNydIwd;

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
        
    // Let's build a query, Obj-C is lovely in this way, where we can scaffold queries with actual data types...
    
    // Oh, and it should 'know' if it's going to be a retr or a clean slate.
    
    if (AppDelegate.nvShouldRetrFromUserEntries == YES) {
        // This one uses a SLIGHTLY different data source than the query below (ID rather than DomainCode), but it's not THAT hacky?
        @try {
            nextQuery = [NSString stringWithFormat:@"SELECT * FROM 'userentries' WHERE `id`='%@'", AppDelegate.nextDomain];
            
            if (nextQuery) {
                shouldPopulateNydIwd = YES;
            } else {
                @throw nextQuery;
            }
        }
        @catch (NSException *exception) {
            NSLog(@"That query did not present user data – defaulting to a clean state in panic. %@", nextQuery);
            nextQuery = [NSString stringWithFormat:@"SELECT * FROM 'domains' WHERE `domaincode`='%@'", AppDelegate.nextDomain];
            
            AppDelegate.nvShouldRetrFromUserEntries = NO;
            AppDelegate.nextDomain = [viewData objectForKey:@"code"];
            shouldPopulateNydIwd = NO;
        }
        @finally {
            
        }
    } else {
        // Using domaincode to create a clean state
        nextQuery = [NSString stringWithFormat:@"SELECT * FROM 'domains' WHERE `domaincode`='%@'", AppDelegate.nextDomain];
    }
        
    // Populate the views' data...
    viewData = [self runQueryForDomainKey];
    if ([viewData valueForKey:@"code"]) {
        
        [determineDomainUIImageForReturn alloc];
        
        // Establish the view data from the database :)
        domainTitle.text = [viewData valueForKey:@"domainTitle"];
        domainSubtitle.text = [viewData valueForKey:@"domainSubtitle"];
        subdomaintitle.text = [viewData valueForKey:@"subdomainTitle"];
        subdomainBody.text = [viewData valueForKey:@"subdomainBody"];
        [domainImage setImage:[UIImage imageNamed:[determineDomainUIImageForReturn imageToWrapInImageView:[viewData valueForKey:@"domainTitle"]]]];
        subdomainGuidingQuestions.text = [NSString stringWithFormat:@"%@ %@ - Guiding Questions:", [viewData valueForKey:@"code"], [viewData valueForKey:@"subdomainTitle"]];
        
        if (shouldPopulateNydIwd == YES) {
            // The person doesn't need to do any more reflection...
            myPastEntries.hidden = YES;
            nextSteps.hidden = YES;
            nydWhatMight.hidden = YES;
            iwdWhatMight.hidden = YES;
            nydTextOutlet.editable = NO;
            iwdTextOutlet.editable = NO;
            
            nydTextOutlet.text = [viewData valueForKey:@"notYet"];
            iwdTextOutlet.text = [viewData valueForKey:@"wellDev"];
            
            sliderOutlet.value = [[viewData valueForKey:@"sliderValue"] integerValue];
        }
        
    } else {
        // If we couldn't, let's throw something at someone.
        [[[UIAlertView alloc] initWithTitle:@"Data Object Failure" message:@"TfEL Maths failed to access the data object and received a null return. Please reinstall the app." delegate:self cancelButtonTitle:@"Exception" otherButtonTitles: nil] show];
        
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
        dispatch_async(queue, ^{ [self dataInconsistency:@"Failed to access that data on the database requested."]; });
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
    AppDelegate.nextDomain = [viewData objectForKey:@"code"];
    shouldPopulateNydIwd = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Now we need to save the values of the text in use
    if (([iwdTextOutlet.text length] >= 2 || [nydTextOutlet.text length] >= 2 ) && shouldPopulateNydIwd == NO  && AppDelegate.nvShouldEnterToUserEntries == YES) {
        static BOOL shouldUpdate = YES;
        
        NSString *saveDataQuery = [NSString stringWithFormat:@"INSERT INTO \"userentries\" (\"id\",\"datemodified\",\"domain_title\",\"domain_subtitle\",\"subdomain_title\",\"subdomain_body\",\"neg_notes\",\"pos_notes\",\"slider_val\",\"domaincode\") VALUES (NULL,time(),'%@','%@','%@','%@','%@','%@','%f', '%@')", [viewData valueForKey:@"domainTitle"], [viewData valueForKey:@"domainSubtitle"], [viewData valueForKey:@"subdomainTitle"], [viewData valueForKey:@"subdomainBody"], nydTextOutlet.text, iwdTextOutlet.text, sliderOutlet.value, [viewData valueForKey:@"code"]];
        
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

- (NSMutableDictionary *) runQueryForDomainKey {
    // Alternately we could provide nextQuery as an inbound, but we can just define it publically and make the query available to the masses.
    // First, let's set the return value to the right type, so we don't break anything..
    NSMutableDictionary *domainData = [[NSMutableDictionary alloc] init];
    
    if (AppDelegate.nvShouldRetrFromUserEntries == YES) {
        // use UserData database
        AppDelegate.databasePath = [NSString stringWithFormat:@"%@/tfeluserdata.sqlite", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]];
    } else {
        // Now we can retreive the query and do something with that...
        AppDelegate.databasePath = [[NSBundle mainBundle] pathForResource:@"tfelmped" ofType:@"sqlite"];
    }
    
    FMDatabase* db = [FMDatabase databaseWithPath:AppDelegate.databasePath];
    
    if (![db open]) {
        NSLog(@"TfEL Maths: Database Establishment Failed");
        [self dataInconsistency:@"No database connection."];
    } else {
        NSLog(@"TfEL Maths: Database Establishment Succeeded");
        
        // Executes the query from the pub 'nextQuery', could be set in a method if it suits better?
        FMResultSet *s = [db executeQuery:nextQuery];
        
        while ([s next]) {
            // Let's pull the neccessary data, we can probably just ignore the id and mod date.
            
            [domainData setValue:[s objectForColumnName:@"domaincode"] forKey:@"code"];
            [domainData setValue:[s objectForColumnName:@"domain_title"] forKey:@"domainTitle"];
            [domainData setValue:[s objectForColumnName:@"domain_subtitle"] forKey:@"domainSubtitle"];
            [domainData setValue:[s objectForColumnName:@"subdomain_title"] forKey:@"subdomainTitle"];
            [domainData setValue:[s objectForColumnName:@"subdomain_body"] forKey:@"subdomainBody"];
            
            if (shouldPopulateNydIwd == YES) {
                [domainData setValue:[s objectForColumnName:@"neg_notes"] forKey:@"notYet"];
                [domainData setValue:[s objectForColumnName:@"pos_notes"] forKey:@"wellDev"];
                [domainData setObject:[s objectForKeyedSubscript:@"slider_val"] forKey:@"sliderValue"];
            }
        }
    }
    
    return domainData;
}

- (void) dataInconsistency: (NSString *)throwReason {
    [NSThread sleepForTimeInterval:2.0f];
    NSLog(@"TfEL Maths Pedagogy Crashed: %@", throwReason);
    @throw NSInternalInconsistencyException;
}


@end
