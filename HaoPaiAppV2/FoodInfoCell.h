//
//  FoodInfoCell.h
//  HaoPaiAppV2
//
//  Created by 高飞 on 12-1-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

@interface FoodInfoCell : TTTableTextItemCell{
    UIImageView *_line;
    UIImageView *_foodImage;
    UILabel *_tip;
    UILabel *_contentLabel;
}
@property (nonatomic, readonly) UIImageView *line;
@property (nonatomic, readonly) UIImageView *foodImage;
@property (nonatomic, readonly) UILabel *tip;
@property (nonatomic, readonly) UILabel *contentLabel;
@end
