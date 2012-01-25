//
//  CitySelectDataSource.m
//  HaoPaiApp
//
//  Created by 高飞 on 11-6-9.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CitySelectDataSource.h"
#import "CitySelectCell.h"
#import "CustomCellBackgroundView.h"
@implementation CitySelectDataSource

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
	CustomCellBackgroundView *custview = [[CustomCellBackgroundView alloc] init];
	custview.fillColor =[UIColor colorWithPatternImage:TTIMAGE(@"bundle://backTile.png")];
	custview.borderColor = [UIColor clearColor];
	if(([tableView numberOfRowsInSection:indexPath.section]-1) == 0){
        custview.position = CustomCellBackgroundViewPositionSingle;
    }
    else if(indexPath.row == 0){
        custview.position = CustomCellBackgroundViewPositionTop;
    }
    else if (indexPath.row == ([tableView numberOfRowsInSection:indexPath.section]-1)){
        custview.position  = CustomCellBackgroundViewPositionBottom;
    }
    else{
        custview.position = CustomCellBackgroundViewPositionMiddle;
    }
	cell.selectedBackgroundView =custview;
	
	[custview release];
	return cell;
}

-(Class) tableView:(UITableView *)tableView cellClassForObject:(id)object{
	if ([object isMemberOfClass:[TTTableTextItem class]]) {
		return [CitySelectCell  class];
	}else{
		return [super tableView:tableView cellClassForObject:object];
	}
}

@end
