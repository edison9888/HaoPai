//
//  SearchStartDataSource.m
//  HaoPaiApp
//
//  Created by 高飞 on 11-6-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SearchStartDataSource.h"
#import "SearchStartCell.h"
#import "CustomCellBackgroundView.h"
@implementation SearchStartDataSource


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
	if ([object isKindOfClass:[TTTableTextItem class]]) {
		return [SearchStartCell class];
	}else {
		return [super tableView:tableView cellClassForObject:object];
	}
}

@end
