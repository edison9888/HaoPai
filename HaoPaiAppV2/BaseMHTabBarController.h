//
//  BaseMHTabBarController.h
//  HaoPaiAppV2
//
//  Created by 高飞 on 11-12-24.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

@interface BaseMHTabBarController : TTViewController{
    UIView *contentContainerView;
    UIImageView* _navigationHeader;
}
@property (nonatomic, readonly)UIView *contentContainerView;
@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, copy) NSArray *viewControllers;
@property (nonatomic, weak) UIViewController *selectedViewController;
@end
