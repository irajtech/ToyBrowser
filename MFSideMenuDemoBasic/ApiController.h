//
//  ApiController.h
//  HyperVerge
//
//  Created by tcs on 23/11/14.
//  Copyright (c) 2014 University of Wisconsin - Madison. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchResults.h"

#define API_KEY @"w1Iys3FvK9jPFtd9mlI8BwXLOLU_"
#define END_POINT @"http://www.faroo.com/"

@interface ApiController : NSObject


+ (NSMutableArray *)getSearchResults:(NSString *)query  searchSource:(NSString *)source forPage:(NSInteger)page pageSize:(NSInteger)pageSize;

@end
