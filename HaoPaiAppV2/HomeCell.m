//
//  HomeCell.m
//  HaoPaiAppV2
//
//  Created by 高飞 on 11-12-24.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "HomeCell.h"
#import "UIImageView+WebCache.h"
@implementation HomeCell

-(void)dealloc{
    TT_RELEASE_SAFELY(_picImage);
    TT_RELEASE_SAFELY(_line);
    TT_RELEASE_SAFELY(_avatarImage);
    TT_RELEASE_SAFELY(_timeLabel);
    TT_RELEASE_SAFELY(_titleLabel);
    TT_RELEASE_SAFELY(_commentsLabel);
    TT_RELEASE_SAFELY(_otherLabel);
    [super dealloc];
}

+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object{
    return 115;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.picImage.frame = CGRectMake(10, 10, 90, 93);
    self.avatarImage.frame = CGRectMake(110, 10, 25, 25);
    self.nameLabel.frame = CGRectMake(140, 11, 100, 21);
    self.timeLabel.frame = CGRectMake(237, 11, 70, 21);
    self.titleLabel.frame = CGRectMake(110, 37, 200, 21);
    self.commentsLabel.frame = CGRectMake(110, 60, 200, 30);
    [self.commentsLabel sizeToFit];
    if (self.commentsLabel.frame.size.height>30) {
        self.commentsLabel.frame = CGRectMake(self.commentsLabel.frame.origin.x, self.commentsLabel.frame.origin.y, self.commentsLabel.frame.size.width, 30);
    }
    self.otherLabel.frame =  CGRectMake(110, 92, 200, 13);
    self.line.frame = CGRectMake(0, 114, 320, 0.5);
}

-(void)setObject:(id)object{
    [super setObject:object];
    self.accessoryType = UITableViewCellAccessoryNone;
	self.selectionStyle = UITableViewCellSelectionStyleBlue;
    self.nameLabel.text = @"在劫难逃";
    self.timeLabel.text = @"5分钟";
    self.titleLabel.text = @"铁板茄子@青柠檬花园餐厅";
    self.otherLabel.text = @"美味值 8 评论 113";
    self.commentsLabel.text = @"点评:铁板茄子@青柠檬花园餐厅铁板茄子@青柠檬花园餐厅铁板茄子@青柠檬花园餐厅铁板茄子@青柠檬花园餐厅铁板茄子@青柠檬花园餐厅铁板茄子@青柠檬花园餐厅铁板茄子@青柠檬花园餐厅铁板茄子@青柠檬花园餐厅铁板茄子@青柠檬花园餐厅";
}

-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = RGBCOLOR(221, 221, 221);
        [self addSubview:_line];
    }
    return _line;
}

-(UIImageView *)picImage{
    if (!_picImage) {
        _picImage = [[UIImageView alloc] init];
        _picImage.backgroundColor = [UIColor grayColor];
        [self addSubview:_picImage];
    }
    return _picImage;
}

-(UIImageView *)avatarImage{
    if (!_avatarImage) {
        _avatarImage = [[UIImageView alloc] init];
        _avatarImage.backgroundColor = [UIColor grayColor];
        [self addSubview:_avatarImage];
    }
    return _avatarImage;
}

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont boldSystemFontOfSize:13];
        _nameLabel.backgroundColor = [UIColor whiteColor];
        [self addSubview:_nameLabel];
    }
    return  _nameLabel;
}

-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textColor = kGryColor;
        _timeLabel.backgroundColor = [UIColor whiteColor];
        _timeLabel.textAlignment = UITextAlignmentRight;
        [self addSubview:_timeLabel];
    }
    return  _timeLabel;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        [self addSubview:_titleLabel];
    }
    return  _titleLabel;
}

-(UILabel *)commentsLabel{
    if (!_commentsLabel) {
        _commentsLabel = [[UILabel alloc] init];
        _commentsLabel.font = [UIFont systemFontOfSize:12];
        _commentsLabel.textColor = kGryColor;
        _commentsLabel.backgroundColor = [UIColor whiteColor];
        _commentsLabel.numberOfLines = 0;
        _commentsLabel.contentMode = UIViewContentModeTop;
        [self addSubview:_commentsLabel];
    }
    return  _commentsLabel;
}

-(UILabel *)otherLabel{
    if (!_otherLabel) {
        _otherLabel = [[UILabel alloc] init];
        _otherLabel.font = [UIFont systemFontOfSize:12];
        _otherLabel.textColor = kGryColor;
        _otherLabel.backgroundColor = [UIColor whiteColor];
        _otherLabel.textAlignment = UITextAlignmentRight;
        [self addSubview:_otherLabel];
    }
    return  _otherLabel;
}


@end
