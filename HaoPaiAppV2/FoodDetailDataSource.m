//
//  FoodDetailDataSource.m
//  HaoPaiAppV2
//
//  Created by 高飞 on 12-1-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FoodDetailDataSource.h"
#import "HomeCell.h"
#import "FoodInfoCell.h"
@implementation FoodDetailDataSource


-(Class) tableView:(UITableView *)tableView cellClassForObject:(id)object{
	if ([object isMemberOfClass:[TTTableTextItem class]]) {
		return [HomeCell class];
	}	if ([object isMemberOfClass:[TTTableMessageItem class]]) {
		return [FoodInfoCell class];
	}else{
		return [super tableView:tableView cellClassForObject:object];
	}
}

@end
