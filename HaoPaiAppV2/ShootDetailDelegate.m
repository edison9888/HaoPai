//
//  ShootDetailDelegate.m
//  HaoPaiAppV2
//
//  Created by 高飞 on 11-12-26.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ShootDetailDelegate.h"

@implementation ShootDetailDelegate

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIScrollViewDelegate


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)scrollViewDidScroll:(UIScrollView*)scrollView {
    [super scrollViewDidScroll:scrollView];
    if ([self.controller respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.controller scrollViewDidScroll:scrollView];
    }
}

@end
