//
//  ShopReviewCell.m
//  HaoPaiAppV2
//
//  Created by 高飞 on 12-1-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ShopReviewCell.h"

@implementation ShopReviewCell

-(void)layoutSubviews{
    [super layoutSubviews];
    self.textLabel.frame = CGRectMake(195, self.textLabel.frame.origin.y, 120, self.textLabel.frame.size.height);
    self.titleStyle.frame = CGRectMake(15, self.textLabel.frame.origin.y, 200, self.textLabel.frame.size.height);
    self.line.frame = CGRectMake(0, 43, 320, 0.5);
}

-(void)setObject:(id)object{
    [super setObject:object];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	self.selectionStyle = UITableViewCellSelectionStyleBlue;
    self.textLabel.textColor = RGBCOLOR(192, 192, 192);
    self.textLabel.font = [UIFont systemFontOfSize:16];
    self.titleStyle.text = [((TTTableTextItem*)object).userInfo objectForKey:@"styleText"];
    self.textLabel.highlightedTextColor = kGryColor;
}

-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = RGBCOLOR(221, 221, 221);
        [self addSubview:_line];
    }
    return _line;
}

-(TTStyledTextLabel *)titleStyle{
    if (!_titleStyle) {
        _titleStyle =  [[TTStyledTextLabel alloc] init];
        _titleStyle.textAlignment = UITextAlignmentLeft;
        _titleStyle.font = [UIFont boldSystemFontOfSize:17];
        _titleStyle.backgroundColor = [UIColor clearColor];
        [self addSubview:_titleStyle];
    }
    return _titleStyle;
}

@end
