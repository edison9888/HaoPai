//
//  SearchStartCell.m
//  HaoPaiApp
//
//  Created by 高飞 on 11-6-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SearchStartCell.h"


@implementation SearchStartCell

- (void)setObject:(id)object {
	[super setObject:object];
	self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	self.selectionStyle = UITableViewCellSelectionStyleBlue;
	self.textLabel.highlightedTextColor = [UIColor blackColor];
    self.textLabel.backgroundColor = [UIColor clearColor];
	UIImage *accessoryImage = [UIImage imageNamed:@"Disclosure.png"];
	UIImageView *accImageView = [[UIImageView alloc] initWithImage:accessoryImage];
	accImageView.userInteractionEnabled = YES;
	[accImageView setFrame:CGRectMake(0, 0, 15, 15)];
	self.accessoryView = accImageView;
	[accImageView release];
}

@end
