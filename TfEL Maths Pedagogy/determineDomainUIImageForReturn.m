//
//  determineDomainUIImageForReturn.m
//  TfEL Maths Pedagogy
//
//  Created by Aidan Cornelius-Bell on 2/07/2015.
//  Copyright (c) 2015 Department for Education and Child Development. All rights reserved.
//

#import "determineDomainUIImageForReturn.h"

@implementation determineDomainUIImageForReturn

+ (NSString *) imageToWrapInImageView: (NSString *)domainString {
    // This is pretty static, but you know, putting it outside the main file is fun because it's univeral.
    
    NSString *imageToWrapInImageView;
    
    if ([domainString isEqualToString:@"DOMAIN 2"]) { imageToWrapInImageView = @"TfEL-Compass-graphic_Domain-2_Small-yellow"; }
    else if ([domainString isEqualToString:@"DOMAIN 3"]) { imageToWrapInImageView = @"TfEL-Compass-graphic_Domain-2_Small-yellow"; }
    else if ([domainString isEqualToString:@"DOMAIN 4"]) { imageToWrapInImageView = @"TfEL-Compass-graphic_Domain-2_Small-yellow"; }
    else { imageToWrapInImageView = @"TfEL-Compass-graphic_Domain-2_Small-yellow"; NSLog(@"TfEL Maths: This installation has become corrupted and will now close. Please re download the application."); @throw NSInternalInconsistencyException; }
    
    return imageToWrapInImageView;
}

@end
