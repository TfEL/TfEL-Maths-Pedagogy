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
#import "AFNetworking.h"

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

// API KEY
NSString *apiKey = @"f2e155da-849cdf";

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
    
    // Set slider image for recall...
    if (sliderOutlet.value > 0.66) {
        [sliderOutlet setThumbImage:[[UIImage imageNamed:@"thumbup-blk.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17, 0, 0)] forState:UIControlStateNormal];
    } else if (sliderOutlet.value > 0.33) {
        [sliderOutlet setThumbImage:[[UIImage imageNamed:@"thumbside-blk.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17, 0, 0)] forState:UIControlStateNormal];
    } else {
        [sliderOutlet setThumbImage:[[UIImage imageNamed:@"thumbdwn-blk.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17, 0, 0)] forState:UIControlStateNormal];
    }
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
    
    [subdomainBody setFont:[UIFont systemFontOfSize:15]];
    
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
        
        sliderOutlet.value = [[userData valueForKey:@"sliderValue"] floatValue];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"TfEL Maths @Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
    }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    
    nydWhatMight.layer.borderWidth = 1;
    nydWhatMight.layer.borderColor = nydWhatMight.tintColor.CGColor;
    nydWhatMight.layer.cornerRadius = 3;
    
    iwdWhatMight.layer.borderWidth = 1;
    iwdWhatMight.layer.borderColor = iwdWhatMight.tintColor.CGColor;
    iwdWhatMight.layer.cornerRadius = 3;
    
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

    [sliderOutlet setThumbImage:[[UIImage imageNamed:@"thumbside-blk.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17, 0, 0)] forState:UIControlStateNormal];
    
    [subdomainBody setFont:[UIFont systemFontOfSize:15]];
}

- (IBAction) sliderValueChanged:(UISlider *)sender {
    if (sliderOutlet.value > 0.66) {
        [sliderOutlet setThumbImage:[[UIImage imageNamed:@"thumbup-blk.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17, 0, 0)] forState:UIControlStateNormal];
    } else if (sliderOutlet.value > 0.33) {
        [sliderOutlet setThumbImage:[[UIImage imageNamed:@"thumbside-blk.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17, 0, 0)] forState:UIControlStateNormal];
    } else {
        [sliderOutlet setThumbImage:[[UIImage imageNamed:@"thumbdwn-blk.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17, 0, 0)] forState:UIControlStateNormal];
    }
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
        
        if (shouldUpdate) {
            [abstractionLayer alloc];
            
            AppDelegate.databasePath = [NSString stringWithFormat:@"%@/tfeluserdata.sqlite", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]];
            FMDatabase* db = [FMDatabase databaseWithPath:AppDelegate.databasePath];
            if (![db open]) {
                
            } else {
                // Run the insert sparky...
                if( [db executeUpdate:@"INSERT INTO \"userentries\" (\"id\",\"datemodified\",\"neg_notes\",\"pos_notes\",\"slider_val\",\"domaincode\") VALUES (NULL,time(),?,?,?,?)", nydTextOutlet.text, iwdTextOutlet.text, [NSNumber numberWithFloat:sliderOutlet.value], AppDelegate.nextDomain] ) {
                    NSLog(@"TfEL Maths: Added new data"); AppDelegate.nvShouldEnterToUserEntries = NO;
                }
            }
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

- (IBAction)shareButton:(id)sender {
    
    if ([nydTextOutlet.text length] <= 5 || [iwdTextOutlet.text length] <= 5) {
        [[[UIAlertView alloc] initWithTitle:@"Not Avaliable" message:@"TfEL Maths was not able to create a share URL for your reflection at this time. Please ensure you have entered text into both reflection boxes and try again." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil] show];
    } else {
        // Set up the exchange with das server
        AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        [serializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [serializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        
        
        NSDictionary *parameters = @{ @"source":@"tmp", @"apptoken":apiKey, @"appdata":@{ @"nyd":nydTextOutlet.text, @"iwd":iwdTextOutlet.text }};
        
        manager.requestSerializer = serializer;
        
        NSString *requestUrl = [NSString stringWithFormat:@"https://maths.tfel.edu.au/a/v1/%@", apiKey];
        
        [manager POST:requestUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"JSON: %@", responseObject);
            
            if ([responseObject objectForKey:@"url"]) {
                NSString *sheetDescription = [NSString stringWithFormat:@"Sharing my TfEL Maths Pedagogy reflection. %@ #TfEL #TfELTalk", [responseObject objectForKey:@"url"]];
                NSArray *shareSheetItems = @[sheetDescription];
                
                UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:shareSheetItems applicationActivities:nil];
                
                UIPopoverController *popup = [[UIPopoverController alloc] initWithContentViewController:controller];
                
                [popup presentPopoverFromRect:[[self.shareButtonRef valueForKey:@"view"] frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [[[UIAlertView alloc] initWithTitle:@"Not Avalialbe" message:@"TfEL Maths was not able to create a share URL for your reflection at this time. Please ensure you have internet access and try again." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil] show];
        }];
    }
}


@end
