//
//  CitySearchDataSource.m
//  HaoPaiApp
//
//  Created by 高飞 on 11-6-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CitySearchDataSource.h"
#import "CitySearchModel.h"

@implementation CitySearchDataSource

- (id<TTModel>)model {
	if (!_model) {
		_model = [[CitySearchModel alloc] init];
	}
	return _model;
}

- (void)tableViewDidLoadModel:(UITableView*)tableView {
	self.items = [NSMutableArray array];
	if (! ((CitySearchModel*)_model).items) {
		TT_RELEASE_SAFELY(_items);
	}else {
		for (NSDictionary* city in ((CitySearchModel*)_model).items) {
			TTTableTextItem* item = [TTTableTextItem itemWithText:[[city objectForKey:@"cn"] stringByReplacingOccurrencesOfString:@"市" withString:@""]];
			item.userInfo = city;
			[_items addObject:item];
		}
	}
}


- (void)search:(NSString*)text {
	[((CitySearchModel*)_model) search:text];
}

@end
