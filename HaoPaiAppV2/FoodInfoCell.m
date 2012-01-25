//
//  FoodInfoCell.m
//  HaoPaiAppV2
//
//  Created by 高飞 on 12-1-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FoodInfoCell.h"

@implementation FoodInfoCell

-(void)dealloc{
    TT_RELEASE_SAFELY(_line);
    TT_RELEASE_SAFELY(_foodImage);
    TT_RELEASE_SAFELY(_tip);
}

+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object{
    if ([[((TTTableMessageItem*)object).userInfo objectForKey:@"extend"] isEqualToString:@"0"]) {
        return 93;
    }else{
        CGSize size =  [@"测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试" 
                        sizeWithFont:[UIFont systemFontOfSize:12]
                        constrainedToSize:CGSizeMake(300, CGFLOAT_MAX)
                        lineBreakMode:UILineBreakModeWordWrap];
        
        return (70+size.height+10);
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.foodImage.frame = CGRectMake(10, 10, 50, 50);
    self.textLabel.frame = CGRectMake(70, 10, 150, 21);
    self.tip.frame = CGRectMake(70, 31, 230, 21);
    if ([[((TTTableMessageItem*)_item).userInfo objectForKey:@"extend"] isEqualToString:@"0"]) {
        self.line.frame = CGRectMake(0, 89, 320, 4);
        self.contentLabel.frame = CGRectMake(10, 70, 300, 13);
    }else{
        CGSize size =  [@"测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试" 
                        sizeWithFont:[UIFont systemFontOfSize:12]
                        constrainedToSize:CGSizeMake(300, CGFLOAT_MAX)
                        lineBreakMode:UILineBreakModeWordWrap];
        self.line.frame = CGRectMake(0, (70+size.height+6), 320, 4);
        self.contentLabel.frame = CGRectMake(10, 70, 300, size.height);
    }
}

-(void)setObject:(id)object{
    [super setObject:object];
    self.contentLabel.text = @"测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试";
    self.textLabel.textColor = RGBCOLOR(240, 114, 0);
    self.textLabel.font = [UIFont boldSystemFontOfSize:17];
    self.tip.text = @"美食 111 粉丝 10000 关注 10000";
    
}

-(UILabel *)tip{
    if (!_tip) {
        _tip = [[UILabel alloc] init];
        _tip.font = [UIFont systemFontOfSize:12];
        _tip.textColor = kGryColor;
        _tip.backgroundColor = [UIColor whiteColor];
        //_tip.numberOfLines = 0;
        _tip.contentMode = UIViewContentModeTop;
        [self addSubview:_tip];
    }
    return  _tip;
}

-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:12];
        _contentLabel.backgroundColor = [UIColor whiteColor];
        _contentLabel.numberOfLines = 0;
        _contentLabel.contentMode = UIViewContentModeTop;
        [self addSubview:_contentLabel];
    }
    return _contentLabel;
}

-(UIImageView *)foodImage{
    if (!_foodImage) {
        _foodImage = [[UIImageView alloc] init];
        _foodImage.backgroundColor = [UIColor grayColor];
        [self addSubview:_foodImage];
    }
    return _foodImage;
}

-(UIImageView *)line{
    if (!_line) {
        _line = [[UIImageView alloc] initWithImage:TTIMAGE(@"bundle://liebiaoyinying.png")];
        [self addSubview:_line];
    }
    return _line;
}

@end
