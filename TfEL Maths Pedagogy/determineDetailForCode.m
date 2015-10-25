//
//  determineDetailForCode.m
//  TfEL Maths Pedagogy
//
//  Created by Aidan Cornelius-Bell on 10/07/2015.
//  Copyright (c) 2015 Department for Education and Child Development. All rights reserved.
//

#import "determineDetailForCode.h"
#import "abstractionLayer.h"

@implementation determineDetailForCode

+ (NSMutableDictionary *) domainDetailForCode: (NSString *)domainCode {
    NSMutableDictionary *domainDetailForCode = [[NSMutableDictionary alloc] init];
    
    NSString *databasePath = [[NSBundle mainBundle] pathForResource:@"tfelmped" ofType:@"sqlite"];
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    
    if (![db open]) { return false; } else {
        // So so weird that I'm forced to use SWF even though it's bad practice? go figure.
        FMResultSet *s = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM \"domains\" WHERE `domaincode` = '%@';", domainCode]];
        
        while ([s next]) {
            // Let's pull the neccessary data, we can probably just ignore the id and mod date.
            [domainDetailForCode setValue:[s objectForColumnName:@"domaincode"] forKey:@"code"];
            [domainDetailForCode setValue:[s objectForColumnName:@"domain_title"] forKey:@"domainTitle"];
            [domainDetailForCode setValue:[s objectForColumnName:@"domain_subtitle"] forKey:@"domainSubtitle"];
            [domainDetailForCode setValue:[s objectForColumnName:@"subdomain_title"] forKey:@"subdomainTitle"];
            [domainDetailForCode setValue:[s objectForColumnName:@"subdomain_body"] forKey:@"subdomainBody"];
        }
        return domainDetailForCode;
    }
}

@end
