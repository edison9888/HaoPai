//
//  MoreDataSource.m
//  HaoPaiAppV2
//
//  Created by 高飞 on 12-1-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MoreDataSource.h"
#import "CustomCellBackgroundView.h"
#import "SystemSettingCell.h"
#import "SystemSettingItem.h"
#import "SynchronousItem.h"
#import "SynchronousItemCell.h"

@implementation MoreDataSource

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
	if ([object isMemberOfClass:[SystemSettingItem class]]) {
		return [SystemSettingCell  class];
	}else if ([object isMemberOfClass:[SynchronousItem class]]) {
		return [SynchronousItemCell class];
	}else{
		return [super tableView:tableView cellClassForObject:object];
	}
}

@end
