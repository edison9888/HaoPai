//
//  FoodStartViewController.m
//  HaoPaiAppV2
//
//  Created by 高飞 on 11-12-23.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "FoodStartViewController.h"
#import "FoodStartDataSource.h"
@implementation FoodStartViewController

-(NSString *) tabImageName {
	return @"main-collect";
}

-(void) loadView{
	[super loadView];
    self.tableView.frame = CGRectMake(0, 44, 320, 375);
    self.variableHeightRows = NO;
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIImageView *_foot = [[UIImageView alloc] initWithImage:TTIMAGE(@"bundle://liebiaoyinying.png")];
    _foot.frame = CGRectMake(0, 0, 320, 4);
    self.tableView.tableFooterView = _foot;
    [_foot release];
    
    _titl.text = @"美食集";
    
    self.dataSource = [FoodStartDataSource dataSourceWithObjects:
                       [TTTableTextItem itemWithText:@"长沙十大特色小吃"],
                       [TTTableTextItem itemWithText:@"国庆长假乐享之招牌美食"],nil];
}


-(void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    TTURLAction *urlAction = [TTURLAction actionWithURLPath:@"tt://viewController/FoodDetailViewController"];
	urlAction.animated = YES;
	[[TTNavigator navigator] performSelector:@selector(openURLAction:) 
								  withObject:urlAction 
								  afterDelay:0.0];
}

@end
