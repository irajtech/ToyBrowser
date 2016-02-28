//
//  SearchPaginator.h
//  HyperVerge
//
//  Created by tcs on 23/11/14.
//  Copyright (c) 2014 University of Wisconsin - Madison. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NMPaginator.h"

@interface SearchPaginator : NMPaginator
@property (nonatomic, retain) NSString *query;
@property (nonatomic, retain) NSString *source;
@end
