//
//  SystemSettingCell.h
//  HaoPaiApp
//
//  Created by 高飞 on 11-6-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


@interface SystemSettingCell : TTTableImageItemCell {
	UILabel *_captionLabel;
    UIImageView *_avatar;
	UIView *_line;
}
@property (nonatomic, readonly) UIView *line;
@property (nonatomic, readonly) IBOutlet UILabel *captionLabel;
@end
