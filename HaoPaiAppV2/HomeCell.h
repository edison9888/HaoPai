//
//  HomeCell.h
//  HaoPaiAppV2
//
//  Created by 高飞 on 11-12-24.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

@interface HomeCell : TTTableTextItemCell{
    UIImageView *_picImage;
    UIImageView *_avatarImage;
    UILabel *_nameLabel;
    UILabel *_timeLabel;
    UILabel *_titleLabel;
    UILabel *_commentsLabel;
    UILabel *_otherLabel;
    UIView *_line;
}
@property (nonatomic, readonly) UIView *line;
@property (nonatomic, readonly) UIImageView *picImage;
@property (nonatomic, readonly) UIImageView *avatarImage;
@property (nonatomic, readonly) UILabel *nameLabel;
@property (nonatomic, readonly) UILabel *timeLabel;
@property (nonatomic, readonly) UILabel *titleLabel;
@property (nonatomic, readonly) UILabel *commentsLabel;
@property (nonatomic, readonly) UILabel *otherLabel;
@end
