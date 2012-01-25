//
//  BaseViewController.m
//  HaoPaiAppV2
//
//  Created by 高飞 on 11-12-25.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "BaseViewController.h"

@implementation BaseViewController


-(void) loadView{
	[super loadView];
    _navigationHeader = [[UIImageView alloc] 
                                      initWithImage:[TTIMAGE(@"bundle://menu-top-bg.png")
                                                     stretchableImageWithLeftCapWidth:1
                                                     topCapHeight:44]];
    //_navigationHeader.backgroundColor = RGBCOLOR(94, 138, 0);
    [_navigationHeader setUserInteractionEnabled:YES];
    _navigationHeader.frame = CGRectMake(0, 0, 320, 44);
    [self.view addSubview:_navigationHeader];
    [_navigationHeader release];
    
    _titl = [[UILabel alloc] init];
	_titl.font = [UIFont boldSystemFontOfSize:20];
	_titl.textColor = [UIColor whiteColor];
    
	_titl.shadowColor = [UIColor grayColor];
    _titl.shadowOffset = CGSizeMake(0, -1.0);
	_titl.textAlignment = UITextAlignmentCenter;
	_titl.frame = CGRectMake(70, (44-20)/2, 180, 20);
	
	_titl.backgroundColor = [UIColor clearColor];
	[_navigationHeader addSubview:_titl];
	[_titl release];
}

-(void) viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

@end
