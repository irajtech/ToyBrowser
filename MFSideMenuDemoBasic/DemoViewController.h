//
//  DemoViewController.h
//
//
//  Created by Raj  .
//

#import <UIKit/UIKit.h>
#import "SearchPaginator.h"
#import "SearchResults.h"
#import "TimelineCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "CollectionsCell.h"


@interface DemoViewController : UIViewController <UISearchBarDelegate, NMPaginatorDelegate, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

- (IBAction)pushAnotherPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationItem1;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBarView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentSelection;
@property (nonatomic, retain)  SearchPaginator *searchpaginator;
@property (weak, nonatomic) IBOutlet UITableView *tableViewData;
@property (nonatomic, retain) NSString *scope;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityMonitor;

- (IBAction)segmentChanged:(id)sender;
@end
