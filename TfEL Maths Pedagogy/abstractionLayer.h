//
//  abstractionLayer.h
//  TfEL Maths Pedagogy
//
//  Created by Aidan Cornelius-Bell on 12/06/2015.
//  Copyright (c) 2015 Department for Education and Child Development. All rights reserved.
//

#import "FMDatabase.h"

@interface abstractionLayer : FMDatabase

+ (NSMutableDictionary *) runDictionaryReturnQuery: (NSString *) runQuery
                                                  : (NSArray *) dataToPopulateInDictionary;

@end
