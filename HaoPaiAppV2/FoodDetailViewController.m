//
//  FoodDetailViewController.m
//  HaoPaiAppV2
//
//  Created by 高飞 on 12-1-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FoodDetailViewController.h"
#import "FoodDetailDataSource.h"
@implementation FoodDetailViewController

-(void)backAction{
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)loadView{
    [super loadView];
    self.tableView.frame = CGRectMake(0, 44, 320, 375);
    self.variableHeightRows = YES;
   // self.tableView.rowHeight = 115;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
     _titl.text = @"美食集";
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:TTIMAGE(@"bundle://btn-return.png") forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
	backButton.frame = CGRectMake(10, (44-30)/2, 50, 30);
	[_navigationHeader addSubview:backButton];
    
    TTTableMessageItem *_item1= [TTTableMessageItem itemWithText:@"长沙十大特色小吃"];
    _item1.userInfo = [NSMutableDictionary dictionaryWithObject:@"0" forKey:@"extend"];
    
    self.dataSource = [FoodDetailDataSource dataSourceWithObjects:
                       _item1,
                       [TTTableTextItem itemWithText:@""],nil] ;
}


-(void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([object isMemberOfClass:[TTTableMessageItem class]]) {
        if ([[((TTTableMessageItem*)object).userInfo objectForKey:@"extend"] isEqualToString:@"0"]) {
            [((TTTableMessageItem*)object).userInfo setObject:@"1" forKey:@"extend"];
        }else{
            [((TTTableMessageItem*)object).userInfo setObject:@"0" forKey:@"extend"];
        }
        //产生点击图片时伸缩动画效果
		[self.tableView beginUpdates];
		[self.tableView endUpdates];
		
		[self.tableView scrollToRowAtIndexPath:indexPath
							  atScrollPosition:UITableViewScrollPositionTop 
									  animated:YES];
    }
}

@end
