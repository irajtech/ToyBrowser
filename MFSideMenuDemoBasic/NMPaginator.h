//
//  NMPaginator.h
//
//  Created by Nicolas Mondollot on 07/04/12.
//

#import <Foundation/Foundation.h>

typedef enum {
	RequestStatusNone,
	RequestStatusInProgress,
	RequestStatusDone // request succeeded or failed
} RequestStatus;

@protocol NMPaginatorDelegate
@required
- (void)paginator:(id)paginator didReceiveResults:(NSArray *)results;
@optional
- (void)paginatorDidFailToRespond:(id)paginator;
- (void)paginatorDidReset:(id)paginator;
@end

@interface NMPaginator : NSObject {
	id <NMPaginatorDelegate> delegate;
}

@property (nonatomic, retain) id delegate;
@property (assign) NSInteger pageSize; // number of results per page
@property (assign) NSInteger page; // number of pages already fetched
@property (assign) NSInteger total; // total number of results
@property (assign, readonly) RequestStatus requestStatus;
@property (nonatomic, strong, readonly) NSMutableArray *results;


- (id)initWithPageSize:(NSInteger)pageSize delegate:(id <NMPaginatorDelegate> )paginatorDelegate;
- (void)reset;
- (BOOL)reachedLastPage;

- (void)fetchFirstPage;
- (void)fetchNextPage;

@end
