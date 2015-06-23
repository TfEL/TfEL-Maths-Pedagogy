//
//  abstractionLayer.m
//  TfEL Maths Pedagogy
//
//  Created by Aidan Cornelius-Bell on 12/06/2015.
//  Copyright (c) 2015 Department for Education and Child Development. All rights reserved.
//

#import "abstractionLayer.h"

#import "AppDelegate.h"

// Quick access types...
#define AppDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

@implementation abstractionLayer

+ (BOOL) runBoolReturnQuery: (NSString *) runQuery {
    // Empty...
    BOOL returnSuccess;
    
    // Estab connection...
    AppDelegate.databasePath = [NSString stringWithFormat:@"%@/tfeluserdata.sqlite", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]];
    FMDatabase* db = [FMDatabase databaseWithPath:AppDelegate.databasePath];
    if (![db open]) {
        
    } else {
        // Run the insert sparky...
        returnSuccess = [db executeUpdate:runQuery];
    }
    
    // Give back some code...
    return returnSuccess;
}

+ (NSMutableDictionary *) runDictionaryReturnQuery: (NSString *) runQuery
                                                  : (NSArray *) dataToPopulateInDictionary {
    // Alternately we could provide nextQuery as an inbound, but we can just define it publically and make the query available to the masses.
    // First, let's set the return value to the right type, so we don't break anything..
    NSMutableDictionary *domainData = [[NSMutableDictionary alloc] init];
    
    // Now we can retreive the query and do something with that...
    AppDelegate.databasePath = [[NSBundle mainBundle] pathForResource:@"tfelmped" ofType:@"sqlite"];
    FMDatabase* db = [FMDatabase databaseWithPath:AppDelegate.databasePath];
    
    if (![db open]) {
        NSLog(@"TfEL Maths: Database Establishment Failed");
        [abstractionLayer dataInconsistency:@"No database connection."];
    } else {
        NSLog(@"TfEL Maths: Database Establishment Succeeded");
        
        // run the input query
        FMResultSet *s = [db executeQuery:runQuery];
        
        while ([s next]) {
            for (id arrayElement in dataToPopulateInDictionary) {
                // This one is cleaner than some of the subviews – it names the array value the same way it is named in the DB
                [domainData setValue:[s objectForColumnName:arrayElement] forKey:arrayElement];
            }
        }
    }
    
    return domainData;
}


+ (NSMutableDictionary *) runDictionaryReturnQueryUser: (NSString *) runQuery
                                                      : (NSArray *) dataToPopulateInDictionary {
    // Alternately we could provide nextQuery as an inbound, but we can just define it publically and make the query available to the masses.
    // First, let's set the return value to the right type, so we don't break anything..
    NSMutableDictionary *domainData = [[NSMutableDictionary alloc] init];
    
    // Now we can retreive the query and do something with that...
    AppDelegate.databasePath = [NSString stringWithFormat:@"%@/tfeluserdata.sqlite", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]];
    FMDatabase* db = [FMDatabase databaseWithPath:AppDelegate.databasePath];
    
    if (![db open]) {
        NSLog(@"TfEL Maths: Database Establishment Failed");
        [abstractionLayer dataInconsistency:@"No database connection."];
    } else {
        NSLog(@"TfEL Maths: Database Establishment Succeeded");
        
        // run the input query
        FMResultSet *s = [db executeQuery:runQuery];
        
        while ([s next]) {
            for (id arrayElement in dataToPopulateInDictionary) {
                // This one is cleaner than some of the subviews – it names the array value the same way it is named in the DB
                [domainData setValue:[s objectForColumnName:arrayElement] forKey:arrayElement];
            }
        }
    }
    
    return domainData;
}


// Thrown internally to this class abstraction, because he's dead jim.
+ (void) dataInconsistency: (NSString *)throwReason {
    [NSThread sleepForTimeInterval:2.0f];
    NSLog(@"TfEL Maths Pedagogy Crashed: %@", throwReason);
    @throw NSInternalInconsistencyException;
}

@end
