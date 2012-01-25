//
//  ShootDetailCell.m
//  HaoPaiAppV2
//
//  Created by 高飞 on 11-12-26.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ShootDetailCell.h"
#import "UIImageView+WebCache.h"

@implementation ShootDetailCell

-(void)dealloc{
    TT_RELEASE_SAFELY(_line);
    TT_RELEASE_SAFELY(_avatarImage);
    TT_RELEASE_SAFELY(_timeLabel);
    TT_RELEASE_SAFELY(_commentsLabel);
    [super dealloc];
}

+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object{
    if ([[((TTTableMessageItem*)object).userInfo objectForKey:@"extend"] isEqualToString:@"0"]) {
        return  73;
    }else{
      CGSize size =  [@"测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试" 
         sizeWithFont:[UIFont systemFontOfSize:12]
         constrainedToSize:CGSizeMake(245, CGFLOAT_MAX)
         lineBreakMode:UILineBreakModeWordWrap];
        if (size.height>30) {
            return (15+13+size.height+15);
        }else{
            return 73;
        }
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.avatarImage.frame = CGRectMake(15, 15, 32, 32);
    self.nameLabel.frame = CGRectMake(57, 8, 160, 21);
    //self.commentsLabel.frame = CGRectMake(57, 29, 245, 13);
    [self.commentsLabel sizeToFit];
  //  NSLog(@"height %f",self.commentsLabel.frame.size.height);
    if ([[((TTTableMessageItem*)_item).userInfo objectForKey:@"extend"] isEqualToString:@"0"]
        &&self.commentsLabel.frame.size.height>30) {
        self.commentsLabel.frame  = CGRectMake(57, 29, 245, 30);
        self.line.frame = CGRectMake(0, 72, 320, 0.5);
    }else{
        self.commentsLabel.frame  = CGRectMake(57, 29, 245, self.commentsLabel.frame.size.height);
        CGSize size =  [self.commentsLabel.text 
                        sizeWithFont:[UIFont systemFontOfSize:12]
                        constrainedToSize:CGSizeMake(245, CGFLOAT_MAX)
                        lineBreakMode:UILineBreakModeWordWrap];
        self.line.frame = CGRectMake(0, (15+13+size.height+14), 320, 0.5);
        
    }
    
    self.replyButton.frame = CGRectMake(260, 0, 70, 44);
    
}

-(void)setObject:(id)object{
    [super setObject:object];
    self.accessoryType = UITableViewCellAccessoryNone;
	self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.nameLabel.text = @"Lemonx";
    self.commentsLabel.text = @"测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试";
}

-(UIButton *)replyButton{
    if (!_replyButton) {
        _replyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _replyButton.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        //_replyButton.backgroundColor = [UIColor blackColor];
        [_replyButton setImage:TTIMAGE(@"bundle://icon-comment.png") forState:UIControlStateNormal];
        [_replyButton addTarget:self action:@selector(replyAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_replyButton];
    }
    return _replyButton;
}

-(void)replyAction{
    NSLog(@"replyAction");
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

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont boldSystemFontOfSize:13];
        _nameLabel.textColor = RGBCOLOR(240, 114, 0);
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
       // _commentsLabel.textColor = RGBCOLOR(153, 153, 153);
        _commentsLabel.backgroundColor = [UIColor whiteColor];
        _commentsLabel.numberOfLines = 0;
        _commentsLabel.contentMode = UIViewContentModeTop;
        [self addSubview:_commentsLabel];
    }
    return  _commentsLabel;
}

@end
