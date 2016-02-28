//
//  SearchResults.h
//  HyperVerge
//
//  Created by tcs on 23/11/14.
//  Copyright (c) 2014 University of Wisconsin - Madison. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SearchResults : NSObject
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *kwic;
@property (nonatomic, retain) NSString *content;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NSString *iurl;
@property (nonatomic, retain) NSString *domain;
@property (nonatomic, retain) NSString *author;
@property (nonatomic, retain) NSString *news;
@property (nonatomic, retain) NSString *votes;
@property (nonatomic, retain) NSString *date;



@end
