//
//  ShootDetailDataSource.m
//  HaoPaiAppV2
//
//  Created by 高飞 on 11-12-26.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ShootDetailDataSource.h"
#import "CustomCellBackgroundView.h"
#import "ShootOrganizerCell.h"
#import "RepliesListCell.h"
#import "ShootDetailCell.h"
@implementation ShootDetailDataSource

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
		return [ShootOrganizerCell class];
	}else if ([object isMemberOfClass:[TTTableCaptionItem class]]){
        return [RepliesListCell class];
    }else if([object isMemberOfClass:[TTTableMessageItem class]]){
        return [ShootDetailCell class];
    }else{
		return [super tableView:tableView cellClassForObject:object];
	}
}

@end
