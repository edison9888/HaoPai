//
//  ShopReviewCell.h
//  HaoPaiAppV2
//
//  Created by 高飞 on 12-1-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


@interface ShopReviewCell : TTTableTextItemCell{
    TTStyledTextLabel *_titleStyle;
    UIView *_line;
}
@property (nonatomic, readonly) UIView *line;
@property (nonatomic, readonly)TTStyledTextLabel *titleStyle;
@end
