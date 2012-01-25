//
//  CitySelectCell.m
//  HaoPaiApp
//
//  Created by 高飞 on 11-6-9.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CitySelectCell.h"


@implementation CitySelectCell

- (void)setObject:(id)object {
	[super setObject:object];
	//self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	self.selectionStyle = UITableViewCellSelectionStyleBlue;
}

@end
