//
//  SideMenuViewController.m
//
//
//  Created by Raj  .

#import "SideMenuViewController.h"
#import "MFSideMenu.h"
#import "DemoViewController.h"

@implementation SideMenuViewController
@synthesize userHistory = _userHistory;

#pragma mark -
#pragma mark - UITableViewDataSource

- (void)viewDidLoad {
	[super viewDidLoad];

	_userMenu = [[NSMutableArray alloc]initWithObjects:@"Home", @"Fav", @"Settings", nil];
	self.tableView.frame = [[UIScreen mainScreen] bounds];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if (section == 0) {
		return @"";
	}
	else if (section == 1) {
		return @"";
	}

	return @"";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (section == 0) {
		return 3;
	}
	else if (section == 1) {
		return _userHistory.count;
	}
	return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";

	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}

	if (indexPath.section == 0) {
		cell.textLabel.text = [self.userMenu objectAtIndex:indexPath.row];
	}
	else if (indexPath.section == 1) {
		cell.textLabel.text = [NSString stringWithFormat:@"Item %d", indexPath.row];
	}

	return cell;
}

#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	DemoViewController *demoController = [[DemoViewController alloc] initWithNibName:@"DemoViewController" bundle:nil];
	demoController.title = [NSString stringWithFormat:@"Demo #%d-%d", indexPath.section, indexPath.row];

	UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
	NSArray *controllers = [NSArray arrayWithObject:demoController];
	navigationController.viewControllers = controllers;
	[self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
}

@end
