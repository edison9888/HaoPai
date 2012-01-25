//
//  UserProfileViewController.m
//  HaoPaiAppV2
//
//  Created by 高飞 on 11-12-23.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "UserProfileViewController.h"

@interface UserProfileViewController()
-(void)loadHeadrView;
@end

@implementation UserProfileViewController

-(NSString *) tabImageName {
	return @"main-space";
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
    _titl.text = @"我的豆窝";
    
    [self loadHeadrView];
    
    UIButton *editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [editButton setImage:TTIMAGE(@"bundle://btn-edit-b.png") forState:UIControlStateNormal];
    [editButton setImage:TTIMAGE(@"bundle://btn-edit.png") forState:UIControlStateHighlighted];
   // [editButton addTarget:self action:@selector(shopAction) forControlEvents:UIControlEventTouchUpInside];
	editButton.frame = CGRectMake(10, (44-30)/2, 40, 30);
	[_navigationHeader addSubview:editButton];
    
    
    UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreButton setImage:TTIMAGE(@"bundle://btn-edit-b.png") forState:UIControlStateNormal];
    [moreButton setImage:TTIMAGE(@"bundle://btn-edit.png") forState:UIControlStateHighlighted];
    [moreButton addTarget:self action:@selector(moreAction) forControlEvents:UIControlEventTouchUpInside];
	moreButton.frame = CGRectMake((320-50), (44-30)/2, 40, 30);
	[_navigationHeader addSubview:moreButton];
    
    
    
    self.viewControllers = [NSArray arrayWithObjects:
                            [kAppDelegate loadFromVC:@"FollowListViewController"],
                            [kAppDelegate loadFromVC:@"FollowListViewController"],
                            [kAppDelegate loadFromVC:@"FollowListViewController"],nil];
    
    self.contentContainerView.frame = CGRectMake(0, 171, 320, 246);
}

-(void)moreAction{
    
    TTURLAction *urlAction = [TTURLAction actionWithURLPath:@"tt://viewController/MoreViewController"];
	urlAction.animated = YES;
	[[TTNavigator navigator] performSelector:@selector(openURLAction:) 
								  withObject:urlAction 
								  afterDelay:0.0];
}

-(void)loadHeadrView{
    UIImageView *_head = [[UIImageView alloc] initWithImage:[TTIMAGE(@"bundle://top-purple-bg.png") 
                                                             stretchableImageWithLeftCapWidth:1 
                                                             topCapHeight:1]];
    _head.userInteractionEnabled = YES;    
    _head.frame = CGRectMake(0, 44, 320, 93);
    
    UIImageView *_avatar = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 72, 72)];
    _avatar.backgroundColor = [UIColor grayColor];
    [_head addSubview:_avatar];
    [_avatar release];
    
    UIButton *_upButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_upButton setImage:TTIMAGE(@"bundle://icon-camera.png") forState:UIControlStateNormal];
    _upButton.frame = CGRectMake(5, 54, 77, 72);
    
    _upButton.contentEdgeInsets = UIEdgeInsetsMake(-20, -60, 0, 0);
    [_head addSubview:_upButton];
    
    UILabel *_name = [[UILabel alloc] initWithFrame:CGRectMake(92, 10, 208, 21)];
    _name.font = [UIFont boldSystemFontOfSize:17];
    _name.backgroundColor = [UIColor clearColor];
    _name.text = @"霞子爱小猪";
    [_head addSubview:_name];
    [_name release];
    
    UILabel *_richnessLabel = [[UILabel alloc] initWithFrame:CGRectMake(92, 32, 208, 21)];
    _richnessLabel.font = [UIFont systemFontOfSize:13];
    _richnessLabel.backgroundColor = [UIColor clearColor];
    _richnessLabel.text = @"财富 232";
    [_head addSubview:_richnessLabel];
    [_richnessLabel release];
    
    [self.view addSubview:_head];
    [_head release];
    
    _cookButon = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cookButon setBackgroundImage:TTIMAGE(@"bundle://tab-bg-on-68.png") forState:UIControlStateNormal];
    [_cookButon setBackgroundImage:TTIMAGE(@"bundle://tab-bg-on-68.png") forState:UIControlStateHighlighted];
    // [_dishButon0 addTarget:self action:@selector(dishButonAction:) forControlEvents:UIControlEventTouchUpInside];
    _cookButon.frame = CGRectMake(0, 137, 107, 34);
    [self.view addSubview:_cookButon];
    
    _cookLabel = [[TTStyledTextLabel alloc] initWithFrame:CGRectMake(0, 147, 107, 24)];
    _cookLabel.textAlignment = UITextAlignmentCenter;
    _cookLabel.userInteractionEnabled = YES;
    _cookLabel.font = [UIFont systemFontOfSize:16];
    _cookLabel.backgroundColor = [UIColor clearColor];
    _cookLabel.text = [TTStyledText textFromXHTML:@"<span class=\"yellowText\">美食 229</span>"
                                       lineBreaks:YES URLs:YES];
    [self.view addSubview:_cookLabel];
    [_cookLabel release];
    
    UIButton *_cookButon01 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cookButon01 addTarget:self action:@selector(cookButonAction:) forControlEvents:UIControlEventTouchUpInside];
    _cookButon01.frame = CGRectMake(0, 137, 107, 34);
    [self.view addSubview:_cookButon01];
    
    _collectButon = [UIButton buttonWithType:UIButtonTypeCustom];
    [_collectButon setBackgroundImage:TTIMAGE(@"bundle://tab-bg-68.png") forState:UIControlStateNormal];
    [_collectButon setBackgroundImage:TTIMAGE(@"bundle://tab-bg-68.png") forState:UIControlStateHighlighted];
    _collectButon.frame = CGRectMake(107, 137, 107, 34);
    [self.view addSubview:_collectButon];
    
    _collectLabel = [[TTStyledTextLabel alloc] initWithFrame:CGRectMake(107, 147, 107, 24)];
    _collectLabel.textAlignment = UITextAlignmentCenter;
    _collectLabel.userInteractionEnabled = YES;
    _collectLabel.font = [UIFont systemFontOfSize:16];
    _collectLabel.backgroundColor = [UIColor clearColor];
    _collectLabel.text = [TTStyledText textFromXHTML:@"<span class=\"blackText\">收藏 229</span>"
                                          lineBreaks:YES URLs:YES];
    [self.view addSubview:_collectLabel];
    [_collectLabel release];
    
    UIButton *_collectButon01 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_collectButon01 addTarget:self action:@selector(collectButonAction:) forControlEvents:UIControlEventTouchUpInside];
    _collectButon01.frame = CGRectMake(107, 137, 107, 34);
    [self.view addSubview:_collectButon01];
    
    _draftButon = [UIButton buttonWithType:UIButtonTypeCustom];
    [_draftButon setBackgroundImage:TTIMAGE(@"bundle://tab-bg-68.png") forState:UIControlStateNormal];
    [_draftButon setBackgroundImage:TTIMAGE(@"bundle://tab-bg-68.png") forState:UIControlStateHighlighted];
    _draftButon.frame = CGRectMake(214, 137, 106, 34);
    [self.view addSubview:_draftButon];
    
    _draftLabel = [[TTStyledTextLabel alloc] initWithFrame:CGRectMake(214, 147, 107, 24)];
    _draftLabel.textAlignment = UITextAlignmentCenter;
    _draftLabel.userInteractionEnabled = YES;
    _draftLabel.font = [UIFont systemFontOfSize:16];
    _draftLabel.backgroundColor = [UIColor clearColor];
    _draftLabel.text = [TTStyledText textFromXHTML:@"<span class=\"blackText\">草稿箱 229</span>"
                                        lineBreaks:YES URLs:YES];
    [self.view addSubview:_draftLabel];
    [_draftLabel release];
    
    UIButton *_draftButon01 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_draftButon01 addTarget:self action:@selector(draftButonAction:) forControlEvents:UIControlEventTouchUpInside];
    _draftButon01.frame = CGRectMake(214, 137, 107, 34);
    [self.view addSubview:_draftButon01];

}

-(void)cookButonAction:(id)sender{
    if(self.selectedIndex!=0){
        self.selectedIndex=0;
        self.selectedIndex=0;
        [_cookButon setBackgroundImage:TTIMAGE(@"bundle://tab-bg-on-68.png") forState:UIControlStateNormal];

        [_collectButon setBackgroundImage:TTIMAGE(@"bundle://tab-bg-68.png") forState:UIControlStateNormal];

        [_draftButon setBackgroundImage:TTIMAGE(@"bundle://tab-bg-68.png") forState:UIControlStateNormal];
        
        _cookLabel.text = [TTStyledText textFromXHTML:@"<span class=\"yellowText\">美食 229</span>"
                                           lineBreaks:YES URLs:YES];
        
        _collectLabel.text = [TTStyledText textFromXHTML:@"<span class=\"blackText\">收藏 229</span>"
                                              lineBreaks:YES URLs:YES];
        
        _draftLabel.text = [TTStyledText textFromXHTML:@"<span class=\"blackText\">草稿箱 229</span>"
                                            lineBreaks:YES URLs:YES];

    }
}

-(void)collectButonAction:(id)sender{
    if(self.selectedIndex!=1){
        self.selectedIndex=1;
        [_cookButon setBackgroundImage:TTIMAGE(@"bundle://tab-bg-68.png") forState:UIControlStateNormal];
        
        [_collectButon setBackgroundImage:TTIMAGE(@"bundle://tab-bg-on-68.png") forState:UIControlStateNormal];
        
        [_draftButon setBackgroundImage:TTIMAGE(@"bundle://tab-bg-68.png") forState:UIControlStateNormal];
        
        _cookLabel.text = [TTStyledText textFromXHTML:@"<span class=\"blackText\">美食 229</span>"
                                           lineBreaks:YES URLs:YES];
        
        _collectLabel.text = [TTStyledText textFromXHTML:@"<span class=\"yellowText\">收藏 229</span>"
                                              lineBreaks:YES URLs:YES];
        
        _draftLabel.text = [TTStyledText textFromXHTML:@"<span class=\"blackText\">草稿箱 229</span>"
                                            lineBreaks:YES URLs:YES];
        
    }
}

-(void)draftButonAction:(id)sender{
    if(self.selectedIndex!=2){
        self.selectedIndex=2;

        [_cookButon setBackgroundImage:TTIMAGE(@"bundle://tab-bg-68.png") forState:UIControlStateNormal];
        
        [_collectButon setBackgroundImage:TTIMAGE(@"bundle://tab-bg-68.png") forState:UIControlStateNormal];
        
        [_draftButon setBackgroundImage:TTIMAGE(@"bundle://tab-bg-on-68.png") forState:UIControlStateNormal];
        
        _cookLabel.text = [TTStyledText textFromXHTML:@"<span class=\"blackText\">美食 229</span>"
                                           lineBreaks:YES URLs:YES];
        
        _collectLabel.text = [TTStyledText textFromXHTML:@"<span class=\"blackText\">收藏 229</span>"
                                              lineBreaks:YES URLs:YES];
        
        _draftLabel.text = [TTStyledText textFromXHTML:@"<span class=\"yellowText\">草稿箱 229</span>"
                                            lineBreaks:YES URLs:YES];
    }
}

@end

