//
//  ShopReviewDataSource.m
//  HaoPaiAppV2
//
//  Created by 高飞 on 12-1-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ShopReviewDataSource.h"
#import "ShopReviewCell.h"
#import "CustomCellBackgroundView.h"
@implementation ShopReviewDataSource

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

-(Class) tableView:(UITableView *)tableView cellClassForObject:(id)object{
	if ([object isMemberOfClass:[TTTableTextItem class]]) {
		return [ShopReviewCell class];
	}else{
		return [super tableView:tableView cellClassForObject:object];
	}
}

@end
