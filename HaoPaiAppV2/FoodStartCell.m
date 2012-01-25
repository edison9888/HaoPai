//
//  FoodStartCell.m
//  HaoPaiAppV2
//
//  Created by 高飞 on 12-1-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FoodStartCell.h"
#import "UIImageView+WebCache.h"
@implementation FoodStartCell

-(void)dealloc{
    TT_RELEASE_SAFELY(_line);
    TT_RELEASE_SAFELY(_foodImage);
    TT_RELEASE_SAFELY(_tip);
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.foodImage.frame = CGRectMake(10, 10, 50, 50);
    self.textLabel.frame = CGRectMake(70, 10, 230, 21);
    self.tip.frame = CGRectMake(70, 34, 230, 12);
    [self.tip sizeToFit];
    if (self.tip.frame.size.height>28) {
        self.tip.frame = CGRectMake(70, 34, 230, 28);
    }
    self.line.frame = CGRectMake(0, 69, 320, 0.5);
}

-(void)setObject:(id)object{
    [super setObject:object];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	self.selectionStyle = UITableViewCellSelectionStyleBlue;
    self.textLabel.font = [UIFont boldSystemFontOfSize:17];
    self.tip.text = @"测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试";
}

-(UIImageView *)foodImage{
    if (!_foodImage) {
        _foodImage = [[UIImageView alloc] init];
        _foodImage.backgroundColor = [UIColor grayColor];
        [self addSubview:_foodImage];
    }
    return _foodImage;
}


-(UILabel *)tip{
    if (!_tip) {
        _tip = [[UILabel alloc] init];
        _tip.font = [UIFont systemFontOfSize:11];
        _tip.textColor = kGryColor;
        _tip.backgroundColor = [UIColor whiteColor];
        _tip.numberOfLines = 0;
        _tip.contentMode = UIViewContentModeTop;
        [self addSubview:_tip];
    }
    return  _tip;
}

-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = RGBCOLOR(221, 221, 221);
        [self addSubview:_line];
    }
    return _line;
}

@end
