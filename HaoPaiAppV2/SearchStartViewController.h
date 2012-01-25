//
//  SearchStartViewController.h
//  HaoPaiAppV2
//
//  Created by 高飞 on 11-12-23.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "BaseTableViewController.h"

@interface SearchStartViewController : BaseTableViewController<UISearchBarDelegate>{
    NSString *_cityId;
    NSArray *_citys;
	NSArray *_shopcates;
}
@property (nonatomic, copy) NSArray *citys;
@property (nonatomic, copy) NSString * cityId;
@property (nonatomic, copy) NSArray *shopcates;
@end
