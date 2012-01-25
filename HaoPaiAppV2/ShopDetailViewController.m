//
//  ShopDetailViewController.m
//  HaoPaiAppV2
//
//  Created by 高飞 on 12-1-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ShopDetailViewController.h"

@implementation ShopDetailViewController


-(void)backAction{
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)loadView{
    [super loadView];
    
    UILabel *_titl = [[UILabel alloc] init];
	_titl.font = [UIFont boldSystemFontOfSize:20];
	_titl.textColor = [UIColor whiteColor];
    
	_titl.shadowColor = [UIColor grayColor];
    _titl.shadowOffset = CGSizeMake(0, -1.0);
	_titl.textAlignment = UITextAlignmentCenter;
	_titl.frame = CGRectMake(70, (44-20)/2, 180, 20);
	
	_titl.backgroundColor = [UIColor clearColor];
	[_navigationHeader addSubview:_titl];
	[_titl release];
    
    _titl.text = @"商户信息";
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:TTIMAGE(@"bundle://btn-return.png") forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
	backButton.frame = CGRectMake(10, (44-30)/2, 50, 30);
	[_navigationHeader addSubview:backButton];
    
    UIButton *reviewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [reviewButton setImage:TTIMAGE(@"bundle://btn-i-comment-b.png") forState:UIControlStateNormal];
    [reviewButton addTarget:self action:@selector(reviewAction) forControlEvents:UIControlEventTouchUpInside];
	reviewButton.frame = CGRectMake((320-73), (44-30)/2, 63, 30);
	[_navigationHeader addSubview:reviewButton];
    
    
    [self loadHead];
}

-(void)reviewAction{
    TTURLAction *urlAction = [TTURLAction actionWithURLPath:@"tt://viewController/ShopReviewViewController"];
	urlAction.animated = YES;
	[[TTNavigator navigator] performSelector:@selector(openURLAction:) 
								  withObject:urlAction 
								  afterDelay:0.0];
}

-(void)loadHead{
    UIImageView *_pic = [[UIImageView alloc] initWithFrame:CGRectMake(15, 54, 68, 50)];
    _pic.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_pic];
    [_pic release];
    
    UIButton *_upButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_upButton setImage:TTIMAGE(@"bundle://icon-add.png") forState:UIControlStateNormal];
    _upButton.frame = CGRectMake(10, 54, 73, 63);
    _upButton.contentEdgeInsets = UIEdgeInsetsMake(39, -60, 0, 0);
    [self.view addSubview:_upButton];
    
    UILabel *_name = [[UILabel alloc] initWithFrame:CGRectMake(93, 54, 207, 21)];
    _name.font = [UIFont boldSystemFontOfSize:17];
    _name.text = @"徐记海鲜大酒楼";
    [self.view addSubview:_name];
    [_name release];
    
    TTStyledTextLabel *_serviceLabel = [[TTStyledTextLabel alloc] init];
    _serviceLabel.font = [UIFont systemFontOfSize:13];
    _serviceLabel.text = [TTStyledText textFromXHTML:
                          [NSString stringWithFormat:@"人均 : <span class=\"yellowText\">%@</span>  服务 : %@  环境 : %@",@"260",@"10",@"5"]];
    _serviceLabel.frame = CGRectMake(93, 91, 207, 21);
    [self.view addSubview:_serviceLabel];
    [_serviceLabel release];
    
    UIView *_line = [[UIView alloc] init];
    _line.backgroundColor = RGBCOLOR(221, 221, 221);
    _line.frame = CGRectMake(0, 120, 320, 0.5);
    [self.view addSubview:_line];
    [_line release];
    
    
    UIView *_line2 = [[UIView alloc] init];
    _line2.backgroundColor = RGBCOLOR(221, 221, 221);
    _line2.frame = CGRectMake(0, 160, 320, 0.5);
    [self.view addSubview:_line2];
    [_line2 release];
    
    
    UIView *_line3 = [[UIView alloc] init];
    _line3.backgroundColor = RGBCOLOR(221, 221, 221);
    _line3.frame = CGRectMake(0, 200, 320, 0.5);
    [self.view addSubview:_line3];
    [_line3 release];
    
    UIImageView *_foot = [[UIImageView alloc] initWithImage:TTIMAGE(@"bundle://liebiaoyinying.png")];
    _foot.frame = CGRectMake(0, 240, 320, 4);
    [self.view  addSubview:_foot];
    [_foot release];
    
    UILabel *_address = [[UILabel alloc] initWithFrame:CGRectMake(15, 130, 260, 20)];
    _address.font = [UIFont systemFontOfSize:13];
    _address.text = @"地址 : 长沙市韶山北路169号通信酒店南侧";
    [self.view addSubview:_address];
    [_address release];
    
    UIButton *_addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addButton setImage:TTIMAGE(@"bundle://icon-address.png") forState:UIControlStateNormal];
    _addButton.frame = CGRectMake(0, 120, 320, 40);
    _addButton.contentEdgeInsets = UIEdgeInsetsMake(0, 260, 0, 0);
    [self.view addSubview:_addButton];
    
    
    UILabel *_phone = [[UILabel alloc] initWithFrame:CGRectMake(15, 170, 260, 20)];
    _phone.font = [UIFont systemFontOfSize:13];
    _phone.text = @"电话 : 0731-84137599 84142333";
    [self.view addSubview:_phone];
    [_phone release];
    
    UIButton *_phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_phoneButton setImage:TTIMAGE(@"bundle://icon-phone.png") forState:UIControlStateNormal];
    _phoneButton.frame = CGRectMake(0, 160, 320, 40);
    _phoneButton.contentEdgeInsets = UIEdgeInsetsMake(0, 260, 0, 0);
    [self.view addSubview:_phoneButton];
    
    
    UILabel *_feature = [[UILabel alloc] initWithFrame:CGRectMake(15, 210, 260, 20)];
    _feature.font = [UIFont systemFontOfSize:13];
    _feature.text = @"特色 : 刷卡 免费停车";
    [self.view addSubview:_feature];
    [_feature release];
    
    UIButton *_featureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_featureButton setImage:TTIMAGE(@"bundle://icon-characteristic.png") forState:UIControlStateNormal];
    _featureButton.frame = CGRectMake(0, 200, 320, 40);
    _featureButton.contentEdgeInsets = UIEdgeInsetsMake(0, 260, 0, 0);
    [self.view addSubview:_featureButton];
    
    _dishButon0 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_dishButon0 setBackgroundImage:TTIMAGE(@"bundle://tab-bg-on-62.png") forState:UIControlStateNormal];
    [_dishButon0 setBackgroundImage:TTIMAGE(@"bundle://tab-bg-on-62.png") forState:UIControlStateHighlighted];
   // [_dishButon0 addTarget:self action:@selector(dishButonAction:) forControlEvents:UIControlEventTouchUpInside];
    _dishButon0.frame = CGRectMake(0, 240, 160, 31);
    [self.view addSubview:_dishButon0];
    

    TTStyledTextLabel *_dishTitle = [[TTStyledTextLabel alloc] initWithFrame:CGRectMake(0, 248, 160, 31)];
    _dishTitle.textAlignment = UITextAlignmentCenter;
    _dishTitle.userInteractionEnabled = YES;
    _dishTitle.font = [UIFont systemFontOfSize:14];
    _dishTitle.backgroundColor = [UIColor clearColor];
    _dishTitle.text = [TTStyledText textFromXHTML:@"<span class=\"yellowText\">菜单</span><span class=\"blackText\">(</span><span class=\"yellowText\">15</span><span class=\"blackText\">)</span>" lineBreaks:YES URLs:YES];

    [self.view addSubview:_dishTitle];
    [_dishTitle release];
    _dishButon = [UIButton buttonWithType:UIButtonTypeCustom];
    [_dishButon addTarget:self action:@selector(dishButonAction:) forControlEvents:UIControlEventTouchUpInside];
    _dishButon.frame = CGRectMake(0, 240, 160, 31);
    [self.view addSubview:_dishButon];
    
    

    
    
    _featButton0 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_featButton0 setBackgroundImage:TTIMAGE(@"bundle://tab-bg-62.png") forState:UIControlStateNormal];
    [_featButton0 setBackgroundImage:TTIMAGE(@"bundle://tab-bg-on-62.png") forState:UIControlStateHighlighted];
   // [_featButton0 addTarget:self action:@selector(featButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    _featButton0.frame = CGRectMake(160, 240, 160, 31);
    [self.view addSubview:_featButton0];
    
    TTStyledTextLabel *_featTitle = [[TTStyledTextLabel alloc] initWithFrame:CGRectMake(160, 248, 160, 31)];
    _featTitle.textAlignment = UITextAlignmentCenter;
    _featTitle.userInteractionEnabled = YES;
    _featTitle.font = [UIFont systemFontOfSize:14];
    _featTitle.backgroundColor = [UIColor clearColor];
    _featTitle.text = [TTStyledText textFromXHTML:@"<span class=\"yellowText\">评论</span><span class=\"blackText\">(</span><span class=\"yellowText\">15</span><span class=\"blackText\">)</span>" lineBreaks:YES URLs:YES];
    [self.view addSubview:_featTitle];
    
    _featButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_featButton addTarget:self action:@selector(featButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    _featButton.frame = CGRectMake(160, 240, 160, 31);
    [self.view addSubview:_featButton];
    

    
    self.viewControllers = [NSArray arrayWithObjects:
                            [kAppDelegate loadFromVC:@"FollowListViewController"],
                            [kAppDelegate loadFromVC:@"HotListViewController"],nil];
    
    self.contentContainerView.frame = CGRectMake(0, 271, 320, 200);
}

-(void)dishButonAction:(id)sender{
    if(self.selectedIndex!=0){
        self.selectedIndex=0;
        
        [_dishButon0 setBackgroundImage:TTIMAGE(@"bundle://tab-bg-on-62.png") forState:UIControlStateNormal];
        [_dishButon0 setBackgroundImage:TTIMAGE(@"bundle://tab-bg-on-62.png") forState:UIControlStateHighlighted];
        [_featButton0 setBackgroundImage:TTIMAGE(@"bundle://tab-bg-62.png") forState:UIControlStateNormal];
        [_featButton0 setBackgroundImage:TTIMAGE(@"bundle://tab-bg-on-62.png") forState:UIControlStateHighlighted];
    }
}

-(void)featButtonAction:(id)sender{
    if (self.selectedIndex!=1) {
        self.selectedIndex=1;
        [_featButton0 setBackgroundImage:TTIMAGE(@"bundle://tab-bg-on-62.png") forState:UIControlStateNormal];
        [_featButton0 setBackgroundImage:TTIMAGE(@"bundle://tab-bg-on-62.png") forState:UIControlStateHighlighted];
        [_dishButon0 setBackgroundImage:TTIMAGE(@"bundle://tab-bg-62.png") forState:UIControlStateNormal];
        [_dishButon0 setBackgroundImage:TTIMAGE(@"bundle://tab-bg-on-62.png") forState:UIControlStateHighlighted];
    }
}

@end
