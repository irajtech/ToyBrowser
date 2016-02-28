//
//  SearchPaginator.m
//  HyperVerge
//
//  Created by tcs on 23/11/14.
//  Copyright (c) 2014 University of Wisconsin - Madison. All rights reserved.
//

#import "SearchPaginator.h"
#import "ApiController.h"



@interface SearchPaginator () {
}
- (void)receivedResults:(NSMutableArray *)results total:(NSInteger)total;
- (void)failed;

@end

@implementation SearchPaginator

@synthesize query = _query;
@synthesize source = _source;

- (void)fetchResultsWithPage:(NSInteger)page pageSize:(NSInteger)pageSize {
	//Start an async thread
	dispatch_queue_t fetchQ = dispatch_queue_create("Content fetcher", NULL);
	dispatch_async(fetchQ, ^{
	    NSMutableArray *jsonData;
	    jsonData = [ApiController getSearchResults:_query searchSource:_source forPage:page pageSize:pageSize];
	    // go back to main thread before adding results
	    dispatch_sync(dispatch_get_main_queue(), ^{
	        [self receivedResults:jsonData total:100];
		});
	});
}

@end
