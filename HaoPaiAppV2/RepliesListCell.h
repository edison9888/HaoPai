//
//  RepliesListCell.h
//  HaoPaiAppV2
//
//  Created by 高飞 on 11-12-26.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//
#import "iCarousel.h"

@interface RepliesListCell : TTTableTextItemCell<iCarouselDelegate,iCarouselDataSource>{
    iCarousel *_userList;
    UIImageView *_iconLeft;
    UIImageView *_iconRight;
}
@property (nonatomic, readonly) iCarousel *userList;
@property (nonatomic, readonly) UIImageView *iconLeft;
@property (nonatomic, readonly) UIImageView *iconRight;
@end
