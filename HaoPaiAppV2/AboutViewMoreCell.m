//
//  AboutViewMoreCell.m
//  HaoPaiApp
//
//  Created by 高飞 on 11-7-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AboutViewMoreCell.h"

static const CGFloat kMaxLabelHeight = 2000;
static const UILineBreakMode kLineBreakMode = UILineBreakModeWordWrap;

static const CGFloat kLeft = 10;
static const CGFloat kWidth = 285;

@implementation AboutViewMoreCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier {
	if (self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier]) {
		self.textLabel.font = [UIFont boldSystemFontOfSize:12];
		self.textLabel.textColor = TTSTYLEVAR(textColor);
		self.textLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
		self.textLabel.textAlignment = UITextAlignmentLeft;
		self.textLabel.lineBreakMode = UILineBreakModeTailTruncation;
		self.textLabel.adjustsFontSizeToFitWidth = YES;
		
		self.detailTextLabel.font = TTSTYLEVAR(tableFont);
		self.detailTextLabel.textColor = [UIColor blackColor];
		self.detailTextLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
		self.detailTextLabel.textAlignment = UITextAlignmentLeft;
		self.detailTextLabel.contentMode = UIViewContentModeTop;
		self.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
		self.detailTextLabel.numberOfLines = 0;
	}
	return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TTTableViewCell class public


///////////////////////////////////////////////////////////////////////////////////////////////////
+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)object {
	TTTableSubtitleItem* item = object;
	
	UIFont* font = [UIFont systemFontOfSize:15];
	CGSize size = [item.text sizeWithFont:font
						constrainedToSize:CGSizeMake(kWidth, CGFLOAT_MAX)
							lineBreakMode:kLineBreakMode];
	size.height +=5;
	if (size.height > kMaxLabelHeight) {
		size.height = kMaxLabelHeight;
	}else if (size.height < 40) {
		return size.height = 38 + kTableCellVPadding*2+5;
	}
	
	return size.height + kTableCellVPadding*2+10;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIView


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews {
	[super layoutSubviews];
	
	CGSize captionSize =
	[self.detailTextLabel.text sizeWithFont:self.detailTextLabel.font
						  constrainedToSize:CGSizeMake(kWidth, CGFLOAT_MAX)
							  lineBreakMode:self.textLabel.lineBreakMode];
	
	self.detailTextLabel.frame = CGRectMake(kTableCellHPadding, kTableCellHPadding, captionSize.width, captionSize.height);
		

}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TTTableViewCell


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object {
	if (_item != object) {
		[super setObject:object];
		
		TTTableSubtitleItem* item = object;
		

		
		//if (item.subtitle.length) {
		self.detailTextLabel.text = item.text;
		
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		self.accessoryType = UITableViewCellAccessoryNone;
	}
}



@end
