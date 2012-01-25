//
//  MyStyleCell.m
//  HaoPaiApp
//
//  Created by 高飞 on 11-7-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyStyleCell.h"


@implementation MyStyleCell

-(void) dealloc{
	TT_RELEASE_SAFELY(styleLabel);
	[super dealloc];
}

+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)object {
	return 44;
}


- (void)layoutSubviews {
	[super layoutSubviews];
	self.line.frame = CGRectMake(0, 44, 320, 0.5);
	self.styleLabel.frame = CGRectInset(self.contentView.bounds,
									   kTableCellHPadding, kTableCellVPadding);
}

-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = RGBCOLOR(221, 221, 221);
        [self addSubview:_line];
    }
    return _line;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object {
	if (_item != object) {
		[_item release];
		_item = [object retain];
		
		TTTableStyledTextItem * item = object;
		
		self.styleLabel.text = item.text;
		
		if (TTIsStringWithAnyText(item.accessoryURL)) {
			self.selectionStyle = UITableViewCellSelectionStyleBlue;
			self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		}else {
			self.selectionStyle = UITableViewCellSelectionStyleNone;
			self.accessoryType = UITableViewCellAccessoryNone;
		}

		
		
	}
}

-(TTStyledTextLabel *) styleLabel{
	if (!styleLabel) {
		styleLabel = [[TTStyledTextLabel alloc] init];
		[self.contentView addSubview:styleLabel];
	}
	return styleLabel;
}

@end
