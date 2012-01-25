//
//  AboutViewDataSource.m
//  HaoPaiApp
//
//  Created by 高飞 on 11-7-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AboutViewDataSource.h"
#import "AboutViewMoreCell.h"
#import "MyStyleCell.h"
#import "CustomCellBackgroundView.h"

@implementation AboutViewDataSource

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
	if ([object isMemberOfClass:[TTTableSubtitleItem class]]) {
		return [AboutViewMoreCell class];
	}else if ([object isMemberOfClass:[TTTableStyledTextItem class]]) {
		return [MyStyleCell class];
	}else{
		return [super tableView:tableView cellClassForObject:object];
	}
}


@end
