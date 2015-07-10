//
//  myEntriesTableViewController.m
//  TfEL Maths Pedagogy
//
//  Created by Aidan Cornelius-Bell on 11/06/2015.
//  Copyright (c) 2015 Department for Education and Child Development. All rights reserved.
//

#import "myEntriesTableViewController.h"
#import "AppDelegate.h"
#import "FMDatabase.h"
#import "abstractionLayer.h"
#import "determineDetailForCode.h"

// Quick access types...
#define AppDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

@interface myEntriesTableViewController ()

@end

@implementation myEntriesTableViewController

NSMutableArray *tableViewPopulationDomains;
NSMutableArray *tableViewPopulationTimes;
NSMutableArray *tableViewPopulationIdentifier;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = YES;
    
    AppDelegate.databasePath = [NSString stringWithFormat:@"%@/tfeluserdata.sqlite", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]];
    FMDatabase* db = [FMDatabase databaseWithPath:AppDelegate.databasePath];
    
    tableViewPopulationDomains = [[NSMutableArray alloc] init];
    tableViewPopulationTimes = [[NSMutableArray alloc] init];
    tableViewPopulationIdentifier = [[NSMutableArray alloc] init];
    
    NSString *nextQuery = @"SELECT * FROM userentries";
    
    if (![db open]) {
        NSLog(@"TfEL Maths: Database Establishment Failed");
        [self dataInconsistency:@"Database Connection Failed"];
    } else {
        NSLog(@"TfEL Maths: Database Establishment Succeeded");
        
        // Executes the query from the pub 'nextQuery', could be set in a method if it suits better?
        FMResultSet *s = [db executeQuery:nextQuery];
        
        while ([s next]) {
            // Let's pull the neccessary data, we can probably just ignore the id and mod date.
            
            [determineDetailForCode alloc];
            NSMutableDictionary *domainDetailForCode = [determineDetailForCode domainDetailForCode:AppDelegate.nextDomain];
            
            [tableViewPopulationDomains addObject:[NSString stringWithFormat:@"My entry to: %@ %@", [s objectForColumnName:@"domaincode"], [domainDetailForCode objectForKey:@"subdomainTitle"]]];
            [tableViewPopulationTimes addObject:[NSString stringWithFormat:@"Added: %@", [s objectForColumnName:@"datemodified"]]];
            [tableViewPopulationIdentifier addObject:[s objectForColumnName:@"id"]];
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [tableViewPopulationDomains count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"standard" forIndexPath:indexPath];

    cell.detailTextLabel.text = [tableViewPopulationTimes objectAtIndex:indexPath.row];
    cell.textLabel.text = [tableViewPopulationDomains objectAtIndex:indexPath.row];
    
    NSInteger cellTag = [[tableViewPopulationIdentifier objectAtIndex:indexPath.row] intValue];
    
    cell.tag = cellTag;
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [abstractionLayer alloc];
        [abstractionLayer runBoolReturnQuery:[NSString stringWithFormat:@"DELETE FROM \"userentries\" WHERE ROWID = %@", [tableViewPopulationIdentifier objectAtIndex:indexPath.row]]];
        
        [tableViewPopulationDomains removeObjectAtIndex:indexPath.row];
        [tableViewPopulationIdentifier removeObjectAtIndex:indexPath.row];
        [tableViewPopulationTimes removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    AppDelegate.idForUserData = [NSString stringWithFormat:@"%ld", (long)[sender tag]];
    AppDelegate.nvShouldRetrFromUserEntries = YES;
}

- (void) dataInconsistency: (NSString *)throwReason {
    [NSThread sleepForTimeInterval:2.0f];
    NSLog(@"TfEL Maths Pedagogy Crashed: %@", throwReason);
    @throw NSInternalInconsistencyException;
}

@end
