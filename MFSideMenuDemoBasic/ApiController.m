//
//  ApiController.m
//  HyperVerge
//
//  Created by tcs on 23/11/14.
//  Copyright (c) 2014 University of Wisconsin - Madison. All rights reserved.
//

#import "ApiController.h"

@implementation ApiController


+ (NSMutableArray *)getSearchResults:(NSString *)query searchSource:(NSString *)source forPage:(NSInteger)page pageSize:(NSInteger)pageSize {
	//  http://www.faroo.com/api?q=iphone&start=11&length=10&l=en&src=news&f=json&key=w1Iys3FvK9jPFtd9mlI8BwXLOLU_
	NSString *urlString = [NSString stringWithFormat:@"%@api?q=%@&start=%d&length=%d&l=en&src=%@&f=json&key=%@", END_POINT, query, page, pageSize, source, API_KEY];

	NSURL *url = [NSURL URLWithString:urlString];
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
	[request setHTTPMethod:@"GET"];
    
	NSHTTPURLResponse *response = nil;
	NSError *error = nil;
	NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];

	NSLog(@"Status Code %d", [response statusCode]);
	NSLog(@"Error Code %d", error.code);


	NSMutableArray *posts = [[NSMutableArray alloc] init];

	if (error != nil) {
		[error localizedDescription];

        return posts;
	}

	// Parse output json
	NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
	NSLog(@"JSON %@", json);
    
    NSDictionary *innerJson = [json objectForKey:@"results"];
    
    for (NSDictionary *dict in innerJson) {
        SearchResults *results = [[SearchResults alloc] init];
        results.title = dict[@"title"];
        results.kwic = dict [@"kwic"];
        results.content = dict[@"content"];
        results.url = dict[@"url"];
        results.iurl = dict[@"iurl"];
        results.domain = dict[@"domain"];
        results.author = dict[@"author"];
        results.news = dict[@"news"];
        results.votes = dict[@"votes"];
        results.date = dict[@"date"];
        [posts addObject:results];
    }

    return  posts;
}

@end
