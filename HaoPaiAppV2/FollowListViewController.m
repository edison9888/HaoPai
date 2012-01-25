//
//  FollowListViewController.m
//  HaoPaiAppV2
//
//  Created by 高飞 on 11-12-24.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "FollowListViewController.h"
#import "FollowListDataSource.h"
@implementation FollowListViewController

-(void)loadView{
    [super loadView];
    self.variableHeightRows = NO;
    self.tableView.rowHeight = 115;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.dataSource = [FollowListDataSource dataSourceWithObjects:[TTTableTextItem itemWithText:@""],nil] ;
}

-(void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    TTURLAction *urlAction = [TTURLAction actionWithURLPath:@"tt://viewController/ShootDetailViewController"];
	urlAction.animated = YES;
	[[TTNavigator navigator] performSelector:@selector(openURLAction:) 
								  withObject:urlAction 
								  afterDelay:0.0];
}

@end
