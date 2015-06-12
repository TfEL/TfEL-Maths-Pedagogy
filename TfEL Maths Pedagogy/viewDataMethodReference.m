//
//  viewDataMethodReference.m
//  TfEL Maths Pedagogy
//
//  Created by Aidan Cornelius-Bell on 12/06/2015.
//  Copyright (c) 2015 Department for Education and Child Development. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "getDataByCode.h"

// Setup the view
[getDataByCode alloc];
NSMutableDictionary *presentationElements = [[NSMutableDictionary alloc] init];
presentationElements = [getDataByCode getPresentationElementsFor:AppDelegate.nextDomain :@"What might this look like?"];

domainTitleOutlet.text = [presentationElements objectForKey:@"domainTitleOutlet"];
domainSubtitleOutlet.text = [presentationElements objectForKey:@"domainSubtitleOutlet"];
subdomainTitleOutlet.text = [presentationElements objectForKey:@"subdomainTitleOutlet"];
domainTitleSubdomainTitleOutlet.text = [presentationElements objectForKey:@"domainTitleSubdomainTitleOutlet"];