//
//  MyUISearchBar.m
//  HaoPaiAppV2
//
//  Created by 高飞 on 11-12-26.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "MyUISearchBar.h"

@implementation MyUISearchBar

- (void)setCloseButtonShadowColor:(UIColor *)shadowColor textColor:(UIColor *)textColor{
    UIButton *cancelButton = nil;
    
    for(UIView *subView in self.subviews)
    {
        if([subView isKindOfClass:[UIButton class]])
        {
            cancelButton = (UIButton*)subView;
        }
    }
    
    [cancelButton setTitleShadowColor:shadowColor forState:UIControlStateNormal];
    
    [cancelButton setTitleColor:textColor forState:UIControlStateNormal];
}

@end
