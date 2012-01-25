//
//  ShootOrganizerCell.h
//  HaoPaiAppV2
//
//  Created by 高飞 on 11-12-26.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

@interface ShootOrganizerCell : TTTableTextItemCell{
    UIImageView *_avatarImage;
    UILabel *_nameLabel;
    UILabel *_timeLabel;
    UILabel *_commentsLabel;
    UIView *_line;
    UIImageView *_iconImage;
}
@property (nonatomic, readonly) UIView *line;   
@property (nonatomic, readonly) UIImageView *avatarImage;
@property (nonatomic, readonly) UIImageView *iconImage;
@property (nonatomic, readonly) UILabel *nameLabel;
@property (nonatomic, readonly) UILabel *timeLabel;
@property (nonatomic, readonly) UILabel *commentsLabel;
@end
