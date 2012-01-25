//
//  FollowListDataSource.m
//  HaoPaiAppV2
//
//  Created by 高飞 on 11-12-24.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "FollowListDataSource.h"
#import "HomeCell.h"
@implementation FollowListDataSource

-(Class) tableView:(UITableView *)tableView cellClassForObject:(id)object{
	if ([object isMemberOfClass:[TTTableTextItem class]]) {
		return [HomeCell class];
	}else{
		return [super tableView:tableView cellClassForObject:object];
	}
}

@end
