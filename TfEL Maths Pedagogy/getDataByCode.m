//
//  getDataByCode.m
//  TfEL Maths Pedagogy
//
//  Created by Aidan Cornelius-Bell on 12/06/2015.
//  Copyright (c) 2015 Department for Education and Child Development. All rights reserved.
//

#import "getDataByCode.h"
#import "AppDelegate.h"
#import "abstractionLayer.h"
#import "FMDatabase.h"

// Quick access types...
#define AppDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

@implementation getDataByCode

+ (NSMutableDictionary *) getPresentationElementsFor: (NSString *) domainCode
                                                    : (NSString *) titleFor {
    // Memory space
    NSMutableDictionary *thisViewData = [[NSMutableDictionary alloc] init];
    
    NSMutableDictionary *databaseObjects = [[NSMutableDictionary alloc] init];
    
    [abstractionLayer alloc];
    
    // Query...
    
    databaseObjects = [abstractionLayer runDictionaryReturnQuery:[NSString stringWithFormat:@"SELECT * FROM `domains` WHERE `domaincode`='%@'", domainCode] :[[NSArray alloc] initWithObjects:@"domain_title", @"domain_subtitle", @"subdomain_title", @"subdomain_body", nil]];
    
    
    // Populate...
    [thisViewData setValue:[databaseObjects objectForKey:@"domain_title"] forKey:@"compassImageOutlet"];
    [thisViewData setValue:[databaseObjects objectForKey:@"domain_title"] forKey:@"domainTitleOutlet"];
    [thisViewData setValue:[databaseObjects objectForKey:@"domain_subtitle"] forKey:@"domainSubtitleOutlet"];
    [thisViewData setValue:[databaseObjects objectForKey:@"subdomain_title"] forKey:@"subdomainTitleOutlet"];
    [thisViewData setValue:[databaseObjects objectForKey:@"sundomain_body"] forKey:@"subdomainBodyOutlet"];
    if ([titleFor length] >= 2) {
        [thisViewData setValue:[NSString stringWithFormat:@"%@ %@ – %@", domainCode, [databaseObjects objectForKey:@"subdomain_title"], titleFor] forKey:@"domainTitleSubdomainTitleOutlet"]; // also as "guiding questions"
    } else {
        [thisViewData setValue:[NSString stringWithFormat:@"%@ %@", domainCode, [databaseObjects objectForKey:@"subdomain_title"]] forKey:@"domainTitleSubdomainTitleOutlet"]; // also as "guiding questions"
    }
    
    // Return...
    return thisViewData;
}


@end
