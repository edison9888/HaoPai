//
//  SuggestDataSource.m
//  HaoPaiApp
//
//  Created by 高飞 on 11-7-2.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SuggestDataSource.h"
#import "CitySelectCell.h"
#import "SuggestSearchModel.h"

@implementation SuggestDataSource

@synthesize searchText = _searchText;
- (id<TTModel>)model {
	if (!_model) {
		_model = [[SuggestSearchModel alloc] init];
	}
	return _model;
}

- (void)tableViewDidLoadModel:(UITableView*)tableView {
	self.items = [NSMutableArray array];
	if (! ((SuggestSearchModel*)_model).items) {
		TT_RELEASE_SAFELY(_items);
		self.items = [NSMutableArray array];
		if (TTIsStringWithAnyText(_searchText)) {
			TTTableTextItem* item = [TTTableTextItem itemWithText:_searchText];
			[_items addObject:item];
		}
	}else {
		if (TTIsStringWithAnyText(_searchText)) {
			TTTableTextItem* item = [TTTableTextItem itemWithText:_searchText];
			[_items addObject:item];
		}
		for (NSDictionary* dish in ((SuggestSearchModel*)_model).items) {
			TTTableTextItem* item = [TTTableTextItem itemWithText:[dish objectForKey:@"Word"]];
			item.userInfo = dish;
			[_items addObject:item];
		}
	}
}

-(Class) tableView:(UITableView *)tableView cellClassForObject:(id)object{
	if ([object isMemberOfClass:[TTTableTextItem class]]) {
		return [CitySelectCell  class];
	}else{
		return [super tableView:tableView cellClassForObject:object];
	}
}

- (void)search:(NSString*)text {
	_searchText = text;
	[((SuggestSearchModel*)_model) search:text];
}

@end
