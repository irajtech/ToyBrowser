//
//  DemoViewController.m
//
//
//  Created by Raj  .
//

#import "DemoViewController.h"
#import "MFSideMenu.h"

@implementation DemoViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	return YES;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	if (!self.title) self.title = @"Demo!";

	[self setupMenuBarButtonItems];

	UIView *titleSearch = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 310.0, 44.0)];
	// titleSearch.autoresizingMask = 0;
	_searchBarView.delegate = self;

	self.navigationItem.titleView = titleSearch;

	self.searchBarView.searchBarStyle = UISearchBarStyleMinimal;

	[titleSearch addSubview:_searchBarView];

	self.searchpaginator = [[SearchPaginator alloc]initWithPageSize:10 delegate:self];
	_scope = @"news";

	[self setupTableViewFooter];

	//Initial Set Up
	self.tableViewData.hidden = NO;
	self.collectionView.hidden = YES;


	// Make self the collection view's delegate and datasource.
	[_collectionView setDelegate:self];
	[_collectionView setDataSource:self];

	// Register the CollectionsCell xib file with the collection view. Set the identifier "collectionsCell" that will
	// be used later when cell will be dequeued and to be displayed the collection view cells.
	UINib *collectionsCellNib = [UINib nibWithNibName:@"CollectionsCell" bundle:nil];
	[_collectionView registerNib:collectionsCellNib forCellWithReuseIdentifier:@"collectionsCell"];
}

#pragma mark -
#pragma mark - UIBarButtonItems

- (void)setupMenuBarButtonItems {
	self.navigationItem.rightBarButtonItem = [self rightMenuBarButtonItem];
	if (self.menuContainerViewController.menuState == MFSideMenuStateClosed &&
	    ![[self.navigationController.viewControllers objectAtIndex:0] isEqual:self]) {
		self.navigationItem.leftBarButtonItem = [self backBarButtonItem];
	}
	else {
		self.navigationItem.leftBarButtonItem = [self leftMenuBarButtonItem];
	}
}

- (UIBarButtonItem *)leftMenuBarButtonItem {
	return [[UIBarButtonItem alloc]
	        initWithImage:[UIImage imageNamed:@"home"] style:UIBarButtonItemStyleBordered
	               target:self
	               action:@selector(leftSideMenuButtonPressed:)];
}

- (UIBarButtonItem *)rightMenuBarButtonItem {
	return [[UIBarButtonItem alloc]
	        initWithImage:[UIImage imageNamed:@"refresh.png"] style:UIBarButtonItemStyleBordered
	               target:self
	               action:@selector(rightSideMenuButtonPressed:)];
}

- (UIBarButtonItem *)backBarButtonItem {
	return [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back-arrow"]
	                                        style:UIBarButtonItemStyleBordered
	                                       target:self
	                                       action:@selector(backButtonPressed:)];
}

#pragma mark -
#pragma mark - UIBarButtonItem Callbacks

- (void)backButtonPressed:(id)sender {
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)leftSideMenuButtonPressed:(id)sender {
	[self.menuContainerViewController toggleLeftSideMenuCompletion: ^{
	    [self setupMenuBarButtonItems];
	}];
}

- (void)rightSideMenuButtonPressed:(id)sender {
	[self filterContentForSearchText:_searchBarView];
}

#pragma mark -
#pragma mark - IBActions

- (IBAction)pushAnotherPressed:(id)sender {
	DemoViewController *demoController = [[DemoViewController alloc]
	                                      initWithNibName:@"DemoViewController"
	                                               bundle:nil];

	[self.navigationController pushViewController:demoController animated:YES];
}

- (IBAction)segmentChanged:(id)sender {
	_scope =  [_segmentSelection titleForSegmentAtIndex:_segmentSelection.selectedSegmentIndex];

	if ([_scope isEqualToString:@"image"]) {
		self.tableViewData.hidden = YES;
		self.collectionView.hidden = NO;
	}
	else {
		self.tableViewData.hidden = NO;
		self.collectionView.hidden = YES;
	}

	[self.activityMonitor startAnimating];
	[self filterContentForSearchText:_searchBarView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	// Return the number of sections.
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	// Return the number of rows in the section.
	return self.searchpaginator.results.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	SearchResults *object = [self.searchpaginator.results objectAtIndex:indexPath.row];
	static NSString *CellIdentifier = @"Cell";
	TimelineCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[TimelineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}

	if ([_scope isEqualToString:@"web"] || [_scope isEqualToString:@"news"]) {
		// Get the current object to be displayed
		cell.postTitle.text = object.title;
		cell.postDescription.text = object.kwic;

		[cell.avatar setImageWithURL:[NSURL URLWithString:object.iurl] placeholderImage:[UIImage imageNamed:@"profile_thumb.png"]];
		// Make the Avatar imageview nicely rounded
		CALayer *l = [cell.avatar layer];
		[l setMasksToBounds:YES];
		return cell;
	}
	else {
		return cell;
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 78;
}

#pragma mark - UICollectionView Delegate and Datasource method implementation
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return self.searchpaginator.results.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	SearchResults *object = [self.searchpaginator.results objectAtIndex:indexPath.row];
	// Dequeue a CollectionsCell cell using the "collectionsCell" identifier.
	CollectionsCell *cell = (CollectionsCell *)[_collectionView dequeueReusableCellWithReuseIdentifier:@"collectionsCell" forIndexPath:indexPath];
	[cell.imgSample setImageWithURL:[NSURL URLWithString:object.iurl] placeholderImage:[UIImage imageNamed:@"profile_thumb.png"]];
	return cell;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar1 {
	[self.searchBarView resignFirstResponder];
	[self.searchpaginator.results removeAllObjects];
    [_tableViewData reloadData];
    [self.collectionView reloadData];
    
	// Set the search type from the scope

	self.searchpaginator.query = @"";
	self.searchpaginator.source = _scope;

	[self.searchpaginator fetchFirstPage];
	[self.activityMonitor startAnimating];
}

- (void)filterContentForSearchText:(UISearchBar *)searchBar1 {
	if ([self.searchBarView.text length] > 0) {
		[_searchBarView resignFirstResponder];


		[self.searchpaginator.results removeAllObjects];

		if ([_scope isEqualToString:@"image"]) {
			[self.collectionView reloadData];
		}
		else {
			[_tableViewData reloadData];
		}

		self.searchpaginator.source = _scope;
		self.searchpaginator.query = [self.searchBarView.text stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
		[self.searchpaginator fetchFirstPage];
	}
	else {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Please enter some text" delegate:self
		                                     cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

		[alert show];
	}
}

- (MFSideMenuContainerViewController *)menuContainerViewController {
	return (MFSideMenuContainerViewController *)self.navigationController.parentViewController;
}

// Paginator stuff
- (void)fetchNextPage {
	[self.searchpaginator fetchNextPage];
	[self.activityIndicator startAnimating];
}

- (void)setupTableViewFooter {
	UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
	footerView.backgroundColor = [UIColor clearColor];

	// Set up activity indicator
	UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	activityIndicatorView.center = CGPointMake(footerView.frame.size.width / 2, footerView.frame.size.height / 2);
	activityIndicatorView.hidesWhenStopped = YES;
	self.activityIndicator = activityIndicatorView;
	[footerView addSubview:activityIndicatorView];
	self.tableViewData.tableFooterView = footerView;
}

- (void)paginator:(id)paginator didReceiveResults:(NSArray *)results {
	// update tableview content
	// easy way : call [tableView reloadData];
//    // nicer way : use insertRowsAtIndexPaths:withAnimation:
	[self.activityIndicator stopAnimating];
	[self.activityMonitor stopAnimating];
	NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
	NSInteger i;

	i = [self.searchpaginator.results count] - [results count];

	for (__unused SearchResults *result in results) {
		[indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
		i++;
	}


	if ([_scope isEqualToString:@"image"]) {
		[self.collectionView insertItemsAtIndexPaths:indexPaths];
	}
	else {
		[self.tableViewData beginUpdates];
		[self.tableViewData insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationMiddle];
		[self.tableViewData endUpdates];
	}
}

- (void)paginatorDidReset:(id)paginator {
	[self.tableViewData reloadData];
}

- (void)paginatorDidFailToRespond:(id)paginator {
	// Todo
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	// when reaching bottom, load a new page
	if (scrollView.contentOffset.y == scrollView.contentSize.height - scrollView.bounds.size.height) {
		// ask next page only if we haven't reached last page
		if (![self.searchpaginator reachedLastPage]) {
			// fetch next page of results
			[self fetchNextPage];
		}
	}
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
		if (kind == UICollectionElementKindSectionFooter) {
		UICollectionReusableView *reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];

		if (reusableview == nil) {
			reusableview = [[UICollectionReusableView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
		}

		UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
		footerView.backgroundColor = [UIColor clearColor];
		footerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;

		UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		activityIndicatorView.center = CGPointMake(footerView.frame.size.width / 2, footerView.frame.size.height / 2);
		[activityIndicatorView startAnimating];
		activityIndicatorView.hidesWhenStopped = YES;
		self.activityIndicator = activityIndicatorView;
		[footerView addSubview:activityIndicatorView];
		[reusableview addSubview:footerView];
		return reusableview;
	}

	return nil;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
	// Hide search bar
	[self.searchBarView resignFirstResponder];
	[self.view endEditing:YES];
	//[self.menuContainerViewController setMenuState:MFSideMenuStateLeftMenuOpen];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar1 {
	[searchBar1 sizeToFit];
//	[self.searchBarView resignFirstResponder];
	return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar1 {
	[searchBar1 sizeToFit];
//	[self.searchBarView resignFirstResponder];
	return YES;
}

@end
