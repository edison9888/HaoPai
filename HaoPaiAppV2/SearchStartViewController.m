//
//  SearchStartViewController.m
//  HaoPaiAppV2
//
//  Created by 高飞 on 11-12-23.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "SearchStartViewController.h"
#import "CitySearchViewController.h"
#import "SuggestDataSource.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "SearchStartDataSource.h"
#import "SearchStartDelegate.h"
#import "Three20UICommon/UIViewControllerAdditions.h"
#import "MyUISearchBar.h"
@implementation SearchStartViewController

@synthesize cityId = _cityId;
@synthesize shopcates = _shopcates;
@synthesize citys = _citys;

-(void) dealloc{
	TT_RELEASE_SAFELY(_cityId);
    TT_RELEASE_SAFELY(_citys);
	TT_RELEASE_SAFELY(_shopcates);
	[super dealloc];
}

-(NSString *) tabImageName {
	return @"main-search";
}


-(void)loadView{
    [super loadView];
    _titl.text = @"找美食";
   // self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.variableHeightRows = NO;
    self.tableView.frame = CGRectMake(0, 44, 320, 375);
    
    self.searchViewController = [[[CitySearchViewController alloc] init] autorelease];
	self.searchViewController.dataSource = [[[SuggestDataSource alloc] init] autorelease];
	_searchController.searchBar.delegate = self;
    _searchController.searchBar.tintColor = RGBCOLOR(245, 243, 237);
    UIButton *cancelButton = nil;
    for (UIView *subView in [_searchController.searchBar subviews]) 
    {
        if ([subView isKindOfClass:[UIButton class]]) 
        {
            cancelButton = (UIButton*)subView;
            [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
	//_searchController.searchBar.tintColor = [UIColor lightGrayColor];
	self.tableView.tableHeaderView = _searchController.searchBar;
	_searchController.searchBar.placeholder = @"请输入菜名、餐馆名等";
    
    [self getData];
}



- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    MyUISearchBar *sBar = (MyUISearchBar *)searchBar;
    [sBar setShowsCancelButton:YES];
    [sBar setCloseButtonShadowColor:[UIColor clearColor] textColor:[UIColor blackColor]];
}

-(BOOL) searchBarShouldBeginEditing:(UISearchBar *)searchBar{
	[UIView beginAnimations:@"" context:nil];
   	_navigationHeader.frame = CGRectMake(0, -44, 320, 44);
	self.tableView.frame = CGRectMake(0, 0, 320, 420);
	[UIView setAnimationDuration:0.5];
	[UIView commitAnimations];
	return YES;
}


-(void) searchBarCancelButtonClicked:(UISearchBar *)searchBar{
	[UIView beginAnimations:@"" context:nil];
	_navigationHeader.frame = CGRectMake(0, 0, 320, 44);
	self.tableView.frame = CGRectMake(0, 44, 320, 365);
	[UIView setAnimationDuration:0.1];
	[UIView commitAnimations];
}

-(BOOL) searchBarShouldEndEditing:(UISearchBar *)searchBar{
	if (searchBar.text.length<=0) {
		[UIView beginAnimations:@"" context:nil];
		_navigationHeader.frame = CGRectMake(0, 0, 320, 44);
		self.tableView.frame = CGRectMake(0, 44, 320, 365);
		[UIView setAnimationDuration:0.1];
		[UIView commitAnimations];
	}
	return YES;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
	NSString *temp = [NSString stringWithFormat:@"%@",searchBar.text];
	if (![temp isEmptyOrWhitespace]) {
		[_searchController setActive:NO animated:NO ];
		[self searchBarCancelButtonClicked:nil];
		[self searchText:temp];
	}
}

- (void)setSearchViewController:(TTTableViewController*)searchViewController {
    if (searchViewController) {
        if (nil == _searchController) {
            MyUISearchBar* searchBar = [[[MyUISearchBar alloc] init] autorelease];
            [searchBar sizeToFit];
            
            _searchController = [[TTSearchDisplayController alloc] initWithSearchBar:searchBar
                                                                  contentsController:self];
        }
        
        searchViewController.superController = self;
        _searchController.searchResultsViewController = searchViewController;
        
    } else {
        _searchController.searchResultsViewController = nil;
        TT_RELEASE_SAFELY(_searchController);
    }
}

-(void)getData{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	if (![self.cityId isEqualToString:[defaults objectForKey:@"city_id"]]) {
		self.cityId = [NSString stringWithFormat:@"%@",[defaults objectForKey:@"city_id"]];
		NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:kRESTBaseUrl,@"haopai.hotareacat"]];
		ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
		[request setPostValue:[defaults objectForKey:@"city_id"] forKey:@"city_id" ];
		[request setRequestMethod:@"POST"];
        [request setDelegate:self];
        request.didFinishSelector = @selector(finishRequest:);
        request.didFailSelector = @selector(finishFail:);
		[request startAsynchronous];

	}else {
		NSArray *section = [NSArray arrayWithObjects:@"热门商区",@"分类",nil];
		
		[[NSNotificationCenter defaultCenter] addObserver:self 
												 selector:@selector(gPSLocal) 
													 name:@"GPSLocal" 
												   object:nil];
		self.dataSource = 	[SearchStartDataSource dataSourceWithItems:[NSArray arrayWithObjects:
                                                                        [NSArray arrayWithObject:[TTTableTextItem itemWithText:@"附近"]],
                                                                        self.citys,
                                                                        self.shopcates,nil] 
															 sections:section];
        [self.tableView reloadData];
	}
	
}

-(void)finishFail:(ASIHTTPRequest *)request{
    self.dataSource = [SearchStartDataSource dataSourceWithObjects:@"",nil];
    
    TTErrorView* errorView = [[[TTErrorView alloc] initWithTitle:@""
                                                        subtitle:@"错误"
                                                           image:nil] autorelease];
    errorView.backgroundColor = [UIColor whiteColor];
    self.errorView = errorView;
    [self.tableView reloadData];
}

-(void)finishRequest:(ASIHTTPRequest *)request{
    //NSLog(@"user info %@",[request responseString]);
    NSDictionary *data =[[JSONDecoder decoder] objectWithData:[request responseData]];
    if ([[data objectForKey:@"status"] intValue]==200) {
        
        NSArray *lists = [[data objectForKey:@"result"] objectForKey:@"lists"];
        NSArray *section = [NSArray arrayWithObjects:@"",@"热门商区",@"分类",nil];
        NSMutableArray *items = [NSMutableArray arrayWithCapacity:2];
        
        
        for (int i=0; (i<[lists count]&&i<3); i++) {
            TTTableTextItem *temp = [TTTableTextItem itemWithText:[[lists objectAtIndex:i] objectForKey:@"AreaName"]
                                                              URL:nil];
            temp.userInfo = [lists objectAtIndex:i];
            [items addObject:temp];
        }
        [items addObject:[TTTableTextItem itemWithText:@"全部商圈"]];
        self.citys = items;
        
        NSMutableArray * cates = [NSMutableArray arrayWithCapacity:4];
        TTTableTextItem *item = [TTTableTextItem itemWithText:@"全部"];
        item.userInfo = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"0",@"全部",nil] 
                                                    forKeys:[NSArray arrayWithObjects:@"ShopCateId",@"CateName",nil]];
        [cates addObject:item];
        for (NSDictionary * cate in [[data objectForKey:@"result"] objectForKey:@"cates"]) {
            TTTableTextItem *temp = [TTTableTextItem itemWithText:[cate objectForKey:@"CateName"]
                                                              URL:nil];
            temp.userInfo = cate;
            [cates addObject:temp];
        }
        
        [cates addObject:[TTTableTextItem itemWithText:@"更多..."]];
        self.shopcates = cates;
        
        self.dataSource = 	[SearchStartDataSource dataSourceWithItems:[NSArray arrayWithObjects:
                                                                        [NSArray arrayWithObject:[TTTableTextItem itemWithText:@"附近"]],
                                                                        self.citys,
                                                                        self.shopcates,nil] 
                                                             sections:section];
        [self.tableView reloadData];
    }
}


-(id <UITableViewDelegate>) createDelegate{
	return [[[SearchStartDelegate alloc] initWithController:self] autorelease];
}

@end
