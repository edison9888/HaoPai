//
//  CitySelectViewController.m
//  HaoPaiApp
//
//  Created by 高飞 on 11-6-9.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CitySelectViewController.h"
#import "CitySelectDataSource.h"
#import "CitySearchViewController.h"
#import "CitySearchDataSource.h"

@implementation CitySelectViewController

- (void)loadView {
	[super loadView];
	self.tableView = nil;
	self.tableViewStyle = UITableViewStyleGrouped;
	self.tableView.frame = CGRectMake(0, 44, 320, 375);
	self.variableHeightRows = NO;
	_titl.text = @"城市列表";
	TTButton *cancelButton = [TTButton buttonWithStyle:@"blackToolbarButton:" 
												 title:@"取消"];
	[cancelButton addTarget:self
					 action:@selector(cancelAction)
		   forControlEvents:UIControlEventTouchUpInside];
	
	cancelButton.frame = CGRectMake((320-60), (44-33)/2, 50, 33);
	[_navigationHeader addSubview:cancelButton];
	
	self.searchViewController = [[[CitySearchViewController alloc] init] autorelease];
	self.searchViewController.dataSource = [[[CitySearchDataSource alloc] init] autorelease];
	_searchController.searchBar.delegate = self;
	_searchController.searchBar.tintColor = [UIColor lightGrayColor];
	self.tableView.tableHeaderView = _searchController.searchBar;
	_searchController.searchBar.keyboardType =  UIKeyboardTypeASCIICapable;
	_searchController.searchBar.placeholder = @"输入城市名或拼音首字母查询...";
}

-(void) viewDidUnload{
	self.tableView = nil;
	[super viewDidUnload];
}


-(void)cancelAction{
	[self.navigationController dismissModalViewControllerAnimated:YES];
}


-(BOOL) searchBarShouldBeginEditing:(UISearchBar *)searchBar{
	[UIView beginAnimations:@"" context:nil];
	self.tableView.frame = CGRectMake(0, 0, 320, 420);
   	_navigationHeader.frame = CGRectMake(0, -44, 320, 44);
	[UIView setAnimationDuration:0.5];
	[UIView commitAnimations];
	return YES;
}


-(void) searchBarCancelButtonClicked:(UISearchBar *)searchBar{
	[UIView beginAnimations:@"" context:nil];
	self.tableView.frame = CGRectMake(0, 40.5, 320, 420);
	_navigationHeader.frame = CGRectMake(0, 0, 320, 44);
	[UIView setAnimationDuration:0.5];
	[UIView commitAnimations];
}


-(BOOL) searchBarShouldEndEditing:(UISearchBar *)searchBar{
	if (searchBar.text.length<=0) {
		[UIView beginAnimations:@"" context:nil];
		self.tableView.frame = CGRectMake(0, 40.5, 320, 420);
		_navigationHeader.frame = CGRectMake(0, 0, 320, 44);
		[UIView setAnimationDuration:0.5];
		[UIView commitAnimations];
	}
	return YES;
}

-(void) viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	NSString *gpscityName = @"暂无定位信息";
	if (TTIsStringWithAnyText([kAppDelegate.temporaryValues objectForKey:@"GPSCity"])) {
		gpscityName=[kAppDelegate.temporaryValues objectForKey:@"GPSCity"];
	}
	TTTableTextItem *gpsCtiy = [TTTableTextItem itemWithText:gpscityName];
	gpsCtiy.userInfo = [kAppDelegate.temporaryValues objectForKey:@"GPSCityId"];				 
	TTTableTextItem *city01 = [TTTableTextItem itemWithText:@"北京"];
	city01.userInfo = @"2";
	TTTableTextItem *city02 = [TTTableTextItem itemWithText:@"上海"];
	city02.userInfo = @"1";
	TTTableTextItem *city03 = [TTTableTextItem itemWithText:@"广州"];
	city03.userInfo = @"226";
	TTTableTextItem *city04 = [TTTableTextItem itemWithText:@"深圳"];
	city04.userInfo = @"306";
	TTTableTextItem *city05 = [TTTableTextItem itemWithText:@"成都"];
	city05.userInfo = @"47";
	TTTableTextItem *city06 = [TTTableTextItem itemWithText:@"南京"];
	city06.userInfo = @"282";
	TTTableTextItem *city07 = [TTTableTextItem itemWithText:@"长沙"];
	city07.userInfo = @"127";
	TTTableTextItem *city08 = [TTTableTextItem itemWithText:@"武汉"];
	city08.userInfo = @"187";
	TTTableTextItem *city09 = [TTTableTextItem itemWithText:@"杭州"];
	city09.userInfo = @"148";
	TTTableTextItem *city10 = [TTTableTextItem itemWithText:@"西安"];
	city10.userInfo = @"202";
	
	self.dataSource = [CitySelectDataSource dataSourceWithObjects:@"GPS定位",
					   gpsCtiy,
					   @"热门城市",
					   city01,
					   city02,
					   city03,
					   city04,
					   city05,
					   city06,
					   city07,
					   city08,
					   city09,
					   city10,
					   nil];
}


-(void) didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath{
	if (indexPath.section==0&&[((TTTableTextItem*)object).text isEqualToString:@"暂无定位信息"]) {
		[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
	}else {
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		if (![[defaults objectForKey:@"UserCity"] isEqualToString:((TTTableTextItem*)object).text]) {
			[defaults setObject:((TTTableTextItem*)object).text forKey:@"UserCity"];
			//NSLog(@"((TTTableTextItem*)object).userInfo %@",((TTTableTextItem*)object).userInfo);
			[defaults setObject:((TTTableTextItem*)object).userInfo forKey:@"city_id"];
			[defaults synchronize];
			[[NSNotificationCenter defaultCenter] postNotificationName:@"cityChange" object:nil];
		}
		[self.navigationController dismissModalViewControllerAnimated:YES];
	}
}

-(void)typeSelect:(id)object{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	if (![[defaults objectForKey:@"UserCity"] isEqualToString:((TTTableTextItem*)object).text]) {
		[defaults setObject:((TTTableTextItem*)object).text forKey:@"UserCity"];
		[defaults setObject:[((TTTableTextItem*)object).userInfo objectForKey:@"id"] forKey:@"city_id"];
		[defaults synchronize];
		[[NSNotificationCenter defaultCenter] postNotificationName:@"cityChange" object:nil];
	}
	[self.navigationController dismissModalViewControllerAnimated:YES];
}

@end
