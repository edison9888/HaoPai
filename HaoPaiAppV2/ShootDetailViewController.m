//
//  ShootDetailViewController.m
//  HaoPaiAppV2
//
//  Created by 高飞 on 11-12-25.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ShootDetailViewController.h"
#import "ShootDetailDelegate.h"
#import "ShootDetailDataSource.h"
@implementation ShootDetailViewController

-(void)loadView{
    [super loadView];
    self.tableView.frame = CGRectMake(0, 44, 320, 371);
    self.variableHeightRows = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _titl.text = @"测试";
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:TTIMAGE(@"bundle://btn-return.png") forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
	backButton.frame = CGRectMake(10, (44-30)/2, 50, 30);
	[_navigationHeader addSubview:backButton];
    
    UIButton *shopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shopButton setImage:TTIMAGE(@"bundle://btn-restaurant-b.png") forState:UIControlStateNormal];
    [shopButton addTarget:self action:@selector(shopAction) forControlEvents:UIControlEventTouchUpInside];
	shopButton.frame = CGRectMake((320-60), (44-30)/2, 50, 30);
	[_navigationHeader addSubview:shopButton];
    
    
    _head = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 180)];
    _head.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = _head;
    [_head release];
    
    _pic = [[UIView alloc] initWithFrame:CGRectMake(0, -50, 320, 480)];
    UIImageView *_test = [[UIImageView alloc] initWithImage:TTIMAGE(@"bundle://test.jpg")];
    _test.contentMode = UIViewContentModeScaleAspectFill;
    [_pic addSubview:_test];
    [_test release];
    [_head addSubview:_pic];
    [_pic release];
    TTTableMessageItem *item = [TTTableMessageItem itemWithText:@""];
    item.userInfo = [NSMutableDictionary dictionaryWithObject:@"0" forKey:@"extend"];
    TTTableMessageItem *item1 = [TTTableMessageItem itemWithText:@""];
    item1.userInfo = [NSMutableDictionary dictionaryWithObject:@"0" forKey:@"extend"];
    self.dataSource = [ShootDetailDataSource 
                        dataSourceWithObjects:
                        [TTTableTextItem itemWithText:@""],
                        [TTTableCaptionItem itemWithText:@""],
                        item,
                        item1,nil] ;
}

- (void)scrollViewDidScroll:(UIScrollView*)scrollView {
    if (scrollView.contentOffset.y<0) {
        if ((-50-scrollView.contentOffset.y)<0) {
            _pic.frame = CGRectMake(_pic.frame.origin.x, 
                                    -50-scrollView.contentOffset.y,
                                    _pic.frame.size.width, _pic.frame.size.height);
        }
        //_pic.frame.origin.y+scrollView.contentOffset.y;

        UIView *_header = self.tableView.tableHeaderView;
        _header.frame = CGRectMake(_header.frame.origin.x, 
                                    0+scrollView.contentOffset.y,
                                    _header.frame.size.width, 
                                    (180-scrollView.contentOffset.y));
    }

    // NSLog(@"scrollView.contentOffset.y %f",scrollView.contentOffset.y);
}

-(void)shopAction{//店铺
    TTURLAction *urlAction = [TTURLAction actionWithURLPath:@"tt://viewController/ShopDetailViewController"];
	urlAction.animated = YES;
	[[TTNavigator navigator] performSelector:@selector(openURLAction:) 
								  withObject:urlAction 
								  afterDelay:0.0];
}

-(void)backAction{
	[self.navigationController popViewControllerAnimated:YES];
}

-(id <UITableViewDelegate>) createDelegate{
	return [[[ShootDetailDelegate alloc] initWithController:self] autorelease];
}

-(void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([object isMemberOfClass:[TTTableMessageItem class]]) {//评论选中加高行宽
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
