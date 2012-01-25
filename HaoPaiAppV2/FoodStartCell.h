//
//  FoodStartCell.h
//  HaoPaiAppV2
//
//  Created by 高飞 on 12-1-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

@interface FoodStartCell : TTTableTextItemCell{
    UIImageView *_foodImage;
    UILabel *_tip;
    UIView *_line;
}
@property (nonatomic, readonly) UIView *line;
@property (nonatomic, readonly) UIImageView *foodImage;
@property (nonatomic, readonly) UILabel *tip;
@end
