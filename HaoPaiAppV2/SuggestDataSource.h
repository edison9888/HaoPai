//
//  SuggestDataSource.h
//  HaoPaiApp
//
//  Created by 高飞 on 11-7-2.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
// 模糊　提示


@interface SuggestDataSource : TTListDataSource {
	NSString *_searchText;
}
@property (nonatomic, retain) NSString *searchText;

@end
