//
//  BaseListDataSource.m
//  HaoPaiApp
//
//  Created by 高飞 on 11-6-19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BaseListDataSource.h"
#import "BaseRequestModel.h"
#import "CustomCellBackgroundView.h"
@implementation BaseListDataSource

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
	CustomCellBackgroundView *custview = [[CustomCellBackgroundView alloc] init];
	custview.fillColor =[UIColor colorWithPatternImage:TTIMAGE(@"bundle://backTile.png")];
	custview.borderColor = [UIColor clearColor];
    custview.position = CustomCellBackgroundViewPositionMiddle;
	cell.selectedBackgroundView =custview;
	[custview release];
	return cell;
}

/////////////////////////////////////////////////////////////////////////////////////////////////
//- (void)tableViewDidLoadModel:(UITableView*)tableView {
//	NSMutableArray* items = [[NSMutableArray alloc] init];
//	
//	for (NSDictionary* feed in ((BaseRequestModel*)_model).items) {
//		TTTableTextItem *item = [[TTTableTextItem alloc] init];
//		item.userInfo = feed;
//		[items addObject:item];
//		[item release];
//	}
//	if (!((BaseRequestModel*)_model).finished) {
//		TTTableMoreButton *button = [TTTableMoreButton itemWithText:@"加载更多..."];
//		[items addObject:button];
//	}
//	self.items = items;
//	TT_RELEASE_SAFELY(items);
//}



//滑动到最后一行加载更多
- (void)tableView:(UITableView*)tableView cell:(UITableViewCell*)cell willAppearAtIndexPath:(NSIndexPath*)indexPath {
	[super tableView:tableView cell:cell willAppearAtIndexPath:indexPath];
	if (indexPath.row == self.items.count-1 && [cell isKindOfClass:[TTTableMoreButtonCell class]]) {
		TTTableMoreButton* moreLink = [(TTTableMoreButtonCell *)cell object];
		moreLink.isLoading = YES;
		[(TTTableMoreButtonCell *)cell setAnimating:YES];
		[tableView deselectRowAtIndexPath:indexPath animated:YES];
		[self.model load:TTURLRequestCachePolicyDefault more:YES];		
	}
}

@end
