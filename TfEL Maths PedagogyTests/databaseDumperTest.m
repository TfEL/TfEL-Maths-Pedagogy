//
//  databaseDumperTest.m
//  TfEL Maths Pedagogy
//
//  Created by Aidan Cornelius-Bell on 3/06/2015.
//  Copyright (c) 2015 Department for Education and Child Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "FMDatabase.h"
#import "sqlAdminTableViewController.h"

@interface databaseDumperTest : XCTestCase

@end

@implementation databaseDumperTest

FMDatabase *db;

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"tfelmped.sqlite"];
    
    db = [FMDatabase databaseWithPath:writableDBPath];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
    if (![db open]) {
        NSLog(@"Well, that database ain't open.");
        return;
    } else {
        FMResultSet *s = [db executeQuery:@"SELECT * FROM \"datastore\" LIMIT 0, 30"];
        
        while ([s next]) {
            NSLog(@"id: %d datemodified: %d data: %d", [s intForColumnIndex:0], [s intForColumnIndex:1], [s intForColumnIndex:2]);
        }
    }
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
