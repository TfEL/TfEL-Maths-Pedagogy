//
//  sqlAdminTableViewController.m
//  TfEL Maths Pedagogy
//
//  Created by Aidan Cornelius-Bell on 3/06/2015.
//  Copyright (c) 2015 Department for Education and Child Development. All rights reserved.
//

#import "sqlAdminTableViewController.h"

#import "AppDelegate.h"

// Quick access types...
#define AppDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])


@interface sqlAdminTableViewController ()

@end

@implementation sqlAdminTableViewController

@synthesize probeStatus, resultQuery, nextQuery;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate.databasePath = [[NSBundle mainBundle] pathForResource:@"tfelmped" ofType:@"sqlite"];
    
    FMDatabase* db = [FMDatabase databaseWithPath:AppDelegate.databasePath];

    if (![db open]) {
        NSLog(@"FMBD SQLite Probe Failed");
        probeStatus.text = @"FMDB SQLite Probe Failed";
        return;
    } else {
        probeStatus.text = @"FMDB SQLite Probe Succeeded";
        // Run a dummy query
        FMResultSet *s = [db executeQuery:@"SELECT * FROM \"datastore\" LIMIT 0, 30"];
        while ([s next]) {
            NSLog(@"TfEL Maths: id: %d datemodified: %d data: %d", [s intForColumnIndex:0], [s intForColumnIndex:1], [s intForColumnIndex:2]);
            
            resultQuery.text = [s objectForColumnName:@"data"];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)runNextQuery:(id)sender {
    FMDatabase* db = [FMDatabase databaseWithPath:AppDelegate.databasePath];
    
    if (![db open]) {
        NSLog(@"FMBD SQLite Probe Failed");
        probeStatus.text = @"FMDB SQLite Probe Failed";
        return;
    } else {
        probeStatus.text = @"FMDB SQLite Probe Succeeded";
        // Run a dummy query
        FMResultSet *s = [db executeQuery:nextQuery.text];
        while ([s next]) {
            resultQuery.text = [NSString stringWithFormat:@"Result[0] at: %d\nResult[1]: %@\nResult[2]: %@\nResult[3]: %@\nResult[4]: %@\nResult[5]: %@\nResult[6]: %@\nResult[7]: %@\nResult[8]: %@\nResult[9]: %@\nResult[10]: %@", [s intForColumnIndex:0], [s stringForColumnIndex:1], [s stringForColumnIndex:2], [s stringForColumnIndex:3], [s stringForColumnIndex:4], [s stringForColumnIndex:5], [s stringForColumnIndex:6], [s stringForColumnIndex:7], [s stringForColumnIndex:8], [s stringForColumnIndex:9], [s stringForColumnIndex:10]];
        }
    }
}

@end
