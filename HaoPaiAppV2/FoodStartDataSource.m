//
//  FoodStartDataSource.m
//  HaoPaiAppV2
//
//  Created by 高飞 on 12-1-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FoodStartDataSource.h"
#import "FoodStartCell.h"
@implementation FoodStartDataSource


-(Class) tableView:(UITableView *)tableView cellClassForObject:(id)object{
	if ([object isMemberOfClass:[TTTableTextItem class]]) {
		return [FoodStartCell class];
	}else{
		return [super tableView:tableView cellClassForObject:object];
	}
}

@end
