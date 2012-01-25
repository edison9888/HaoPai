//
//  ShootOrganizerCell.m
//  HaoPaiAppV2
//
//  Created by 高飞 on 11-12-26.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ShootOrganizerCell.h"
#import "UIImageView+WebCache.h"

static const UILineBreakMode kLineBreakMode = UILineBreakModeWordWrap;
@implementation ShootOrganizerCell

-(void)dealloc{
    TT_RELEASE_SAFELY(_line);
    TT_RELEASE_SAFELY(_avatarImage);
    TT_RELEASE_SAFELY(_timeLabel);
    TT_RELEASE_SAFELY(_commentsLabel);
    [super dealloc];
}

+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object{
    UIFont* font = [UIFont systemFontOfSize:12];
	CGSize size = [@"寒月如冰寒月如冰寒月如冰寒月如冰寒月如冰寒月如冰寒月如冰寒月如冰寒月如冰寒月如冰寒月如冰"
                                                           sizeWithFont:font
                                                      constrainedToSize:CGSizeMake(240, CGFLOAT_MAX)
                                                          lineBreakMode:kLineBreakMode];
   //NSLog(@"size %f",(size.height+63+12));
    return  (size.height+30+12);
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.avatarImage.frame = CGRectMake(15, 15, 32, 32);
    self.nameLabel.frame = CGRectMake(57, 13, 160, 21);
    self.timeLabel.frame = CGRectMake(243, 13, 70, 21);
    self.iconImage.frame = CGRectMake(57, 35, 12, 18);
    self.commentsLabel.frame = CGRectMake(70, 35, 240, 21);
    [self.commentsLabel sizeToFit];
    self.line.frame = CGRectMake(0, (self.commentsLabel.frame.size.height+30+12), 320, 0.5);
}


-(void)setObject:(id)object{
    [super setObject:object];
    self.accessoryType = UITableViewCellAccessoryNone;
	self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.nameLabel.text = @"寒月如冰";
    self.timeLabel.text = @"2011-12-27";
    self.commentsLabel.text = @"寒月如冰寒月如冰寒月如冰寒月如冰寒月如冰寒月如冰寒月如冰寒月如冰寒月如冰寒月如冰寒月如冰";
}

-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = RGBCOLOR(221, 221, 221);
        [self addSubview:_line];
    }
    return _line;
}


-(UIImageView *)avatarImage{
    if (!_avatarImage) {
        _avatarImage = [[UIImageView alloc] init];
        _avatarImage.backgroundColor = [UIColor grayColor];
        [self addSubview:_avatarImage];
    }
    return _avatarImage;
}

-(UIImageView *)iconImage{
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc] initWithImage:TTIMAGE(@"bundle://icon-good.png")];
        [self addSubview:_iconImage];
    }
    return _iconImage;
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
        _timeLabel.textColor = RGBCOLOR(153, 153, 153);
        _timeLabel.backgroundColor = [UIColor whiteColor];
        _timeLabel.textAlignment = UITextAlignmentRight;
        [self addSubview:_timeLabel];
    }
    return  _timeLabel;
}


-(UILabel *)commentsLabel{
    if (!_commentsLabel) {
        _commentsLabel = [[UILabel alloc] init];
        _commentsLabel.font = [UIFont systemFontOfSize:12];
        //_commentsLabel.textColor = RGBCOLOR(153, 153, 153);
        _commentsLabel.backgroundColor = [UIColor whiteColor];
        _commentsLabel.numberOfLines = 0;
        _commentsLabel.contentMode = UIViewContentModeTop;
        [self addSubview:_commentsLabel];
    }
    return  _commentsLabel;
}

@end
