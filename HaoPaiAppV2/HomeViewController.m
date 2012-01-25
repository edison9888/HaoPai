//
//  HomeViewController.m
//  HaoPaiAppV2
//
//  Created by 高飞 on 11-12-23.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "HomeViewController.h"

@implementation HomeViewController

-(NSString *) tabImageName {
	return @"main-dynamic";
}



-(void)loadView{
    [super loadView];
    _leftNavigaButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[_leftNavigaButton setBackgroundImage:TTIMAGE(@"bundle://btn-conner.png") forState:UIControlStateNormal];
	[_leftNavigaButton setBackgroundImage:TTIMAGE(@"bundle://btn-conner.png") forState:UIControlStateHighlighted];
	_leftNavigaButton.frame = CGRectMake((320-248)/2,(44-31)/2,83,31);
	[_leftNavigaButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
	//[_leftNavigaButton setTitle:@"收藏" forState:UIControlStateNormal];
	[_leftNavigaButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	_leftNavigaButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
	_leftNavigaButton.titleLabel.textAlignment = UITextAlignmentCenter;
	[_navigationHeader addSubview:_leftNavigaButton];
    
    _centerNavigaButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[_centerNavigaButton setBackgroundImage:TTIMAGE(@"bundle://btn-hot-b.png") forState:UIControlStateNormal];
	[_centerNavigaButton setBackgroundImage:TTIMAGE(@"bundle://btn-hot.png") forState:UIControlStateHighlighted];
	_centerNavigaButton.frame = CGRectMake((320-248)/2+84,(44-31)/2,83,31);
	[_centerNavigaButton addTarget:self action:@selector(centerAction) forControlEvents:UIControlEventTouchUpInside];
	//[_leftNavigaButton setTitle:@"收藏" forState:UIControlStateNormal];
	[_centerNavigaButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	_centerNavigaButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
	_centerNavigaButton.titleLabel.textAlignment = UITextAlignmentCenter;
	[_navigationHeader addSubview:_centerNavigaButton];
    
    _rightNavigaButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[_rightNavigaButton setBackgroundImage:TTIMAGE(@"bundle://btn-new-b.png") forState:UIControlStateNormal];
	[_rightNavigaButton setBackgroundImage:TTIMAGE(@"bundle://btn-new.png") forState:UIControlStateHighlighted];
	_rightNavigaButton.frame = CGRectMake((320-248)/2+84+84,(44-31)/2,83,31);
	[_rightNavigaButton addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
	//[_leftNavigaButton setTitle:@"收藏" forState:UIControlStateNormal];
	[_rightNavigaButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	_rightNavigaButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
	_rightNavigaButton.titleLabel.textAlignment = UITextAlignmentCenter;
	[_navigationHeader addSubview:_rightNavigaButton];
    
    
    self.viewControllers = [NSArray arrayWithObjects:
                            [kAppDelegate loadFromVC:@"FollowListViewController"],
                            [kAppDelegate loadFromVC:@"HotListViewController"],
                            [kAppDelegate loadFromVC:@"NewListViewController"],nil];
    
}

//关注
-(void)leftAction{
	if (self.selectedIndex!=0) {
    
		[_leftNavigaButton setBackgroundImage:TTIMAGE(@"bundle://btn-conner.png") 
                                     forState:UIControlStateNormal];
		[_leftNavigaButton setBackgroundImage:TTIMAGE(@"bundle://btn-conner.png") 
                                     forState:UIControlStateHighlighted];
		
        [_centerNavigaButton setBackgroundImage:TTIMAGE(@"bundle://btn-hot-b.png") 
                                       forState:UIControlStateNormal];
        [_centerNavigaButton setBackgroundImage:TTIMAGE(@"bundle://btn-hot.png") 
                                       forState:UIControlStateHighlighted];
        
		[_rightNavigaButton setBackgroundImage:TTIMAGE(@"bundle://btn-new-b.png") 
                                      forState:UIControlStateNormal];
		[_rightNavigaButton setBackgroundImage:TTIMAGE(@"bundle://btn-new.png") 
                                      forState:UIControlStateHighlighted];

        self.selectedIndex = 0;
	}
}

//最新
-(void)rightAction{
	if (self.selectedIndex!=2) {
		
		[_leftNavigaButton setBackgroundImage:TTIMAGE(@"bundle://btn-conner-b.png") 
                                     forState:UIControlStateNormal];
		[_leftNavigaButton setBackgroundImage:TTIMAGE(@"bundle://btn-conner.png") 
                                     forState:UIControlStateHighlighted];
		
        [_centerNavigaButton setBackgroundImage:TTIMAGE(@"bundle://btn-hot-b.png") 
                                       forState:UIControlStateNormal];
        [_centerNavigaButton setBackgroundImage:TTIMAGE(@"bundle://btn-hot.png") 
                                       forState:UIControlStateHighlighted];
        
		[_rightNavigaButton setBackgroundImage:TTIMAGE(@"bundle://btn-new.png") 
                                      forState:UIControlStateNormal];
		[_rightNavigaButton setBackgroundImage:TTIMAGE(@"bundle://btn-new.png") 
                                      forState:UIControlStateHighlighted];
		
        
        self.selectedIndex = 2;
	}
}

-(void)centerAction{
    if (self.selectedIndex!=1) {
		
		[_leftNavigaButton setBackgroundImage:TTIMAGE(@"bundle://btn-conner-b.png") 
                                     forState:UIControlStateNormal];
		[_leftNavigaButton setBackgroundImage:TTIMAGE(@"bundle://btn-conner.png") 
                                     forState:UIControlStateHighlighted];
		
        [_centerNavigaButton setBackgroundImage:TTIMAGE(@"bundle://btn-hot.png") 
                                       forState:UIControlStateNormal];
        [_centerNavigaButton setBackgroundImage:TTIMAGE(@"bundle://btn-hot.png") 
                                       forState:UIControlStateHighlighted];
        
		[_rightNavigaButton setBackgroundImage:TTIMAGE(@"bundle://btn-new-b.png") 
                                      forState:UIControlStateNormal];
		[_rightNavigaButton setBackgroundImage:TTIMAGE(@"bundle://btn-new.png") 
                                      forState:UIControlStateHighlighted];
		
        
        self.selectedIndex = 1;
	}
}

@end
