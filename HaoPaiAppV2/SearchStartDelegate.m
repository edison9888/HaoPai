//
//  SearchStartDelegate.m
//  HaoPaiAppV2
//
//  Created by 高飞 on 11-12-25.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "SearchStartDelegate.h"

@implementation SearchStartDelegate

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0;
    }else{
        return 40;
    }
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
	UIImageView *_header = [[[UIImageView alloc] 
                            initWithImage:[TTIMAGE(@"bundle://title-bg.png") 
                                           stretchableImageWithLeftCapWidth:1 topCapHeight:2]] autorelease];
    UILabel *title = [[UILabel alloc] init];
	title.frame = CGRectMake(10, 11, 200, 22);
	title.text = [self.controller.dataSource tableView:tableView titleForHeaderInSection:section];
	title.backgroundColor = [UIColor clearColor];
    
	title.font = [UIFont systemFontOfSize:16];
    [_header addSubview:title];
    [title release];
    return _header;
}

@end
