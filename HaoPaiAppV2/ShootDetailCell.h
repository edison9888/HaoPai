//
//  ShootDetailCell.h
//  HaoPaiAppV2
//
//  Created by 高飞 on 11-12-26.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//  

@interface ShootDetailCell : TTTableTextItemCell{
    UIImageView *_avatarImage;
    UILabel *_nameLabel;
    UILabel *_timeLabel;
    UILabel *_commentsLabel;
    UIView *_line;
    UIButton *_replyButton;
}
@property (nonatomic, readonly) UIView *line;   
@property (nonatomic, readonly) UIImageView *avatarImage;
@property (nonatomic, readonly) UILabel *nameLabel;
@property (nonatomic, readonly) UILabel *timeLabel;
@property (nonatomic, readonly) UILabel *commentsLabel;
@property (nonatomic, readonly) UIButton *replyButton;
@end
