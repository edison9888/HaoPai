//
//  SystemSettingCell.m
//  HaoPaiApp
//
//  Created by 高飞 on 11-6-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SystemSettingCell.h"
#import "SystemSettingItem.h"
#import "NSStringAdditions.h"
@implementation SystemSettingCell
@synthesize captionLabel = _captionLabel;


-(void) dealloc{
	TT_RELEASE_SAFELY(_captionLabel);
	[super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier {
	if (self = [super initWithStyle:style reuseIdentifier:identifier]) {
		self.textLabel.highlightedTextColor = [UIColor blackColor];
		self.detailTextLabel.highlightedTextColor = [UIColor blackColor];
		self.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
		self.detailTextLabel.numberOfLines = 0;
	}
	return self;
}

-(UILabel *) captionLabel{
	if (!_captionLabel) {
		_captionLabel = [[UILabel alloc] init];
		_captionLabel.highlightedTextColor = [UIColor blackColor];
		_captionLabel.lineBreakMode = UILineBreakModeWordWrap;
		_captionLabel.numberOfLines = 0;
		_captionLabel.textAlignment = UITextAlignmentRight;
		_captionLabel.font = TTSTYLEVAR(tableFont);
		[self.contentView addSubview:_captionLabel];
	}
	return _captionLabel;
}


-(void) layoutSubviews{
	[super layoutSubviews];
    //[self _commonInit];
    if ([((SystemSettingItem*)_item).imageURL isEmptyOrWhitespace]) {
        self.textLabel.frame = CGRectMake(13, (45-21)/2, 150, 21);
    }else{
        self.textLabel.frame = CGRectMake(55, (45-21)/2, 140, 21);
    }
    
	self.imageView2.frame = CGRectMake(14
                                       , (45-32)/2,
                                       32, 32);
	//NSLog(@"detailTextLabel %@",self.detailTextLabel.text);
	//self.detailTextLabel.frame = CGRectMake(150,10,125,21);
	self.captionLabel.frame = CGRectMake(210,(45-23)/2,86,21);
    self.line.frame = CGRectMake(0, 44, 320, 0.5);
}

-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = RGBCOLOR(221, 221, 221);
        [self addSubview:_line];
    }
    return _line;
}


- (void)_commonInit
{
	//渐变背景
	TTView* view =[[[TTView alloc] init] autorelease];
	//self.textLabel.backgroundColor = [UIColor clearColor];
	view.style = [TTLinearGradientFillStyle styleWithColor1:RGBCOLOR(255, 255, 255)
													 color2:RGBCOLOR(255,255,255) next:
				  nil];
	
	self.backgroundView = view;
	self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	self.backgroundView.frame = self.bounds;
}

- (void)setObject:(id)object {
	[super setObject:object];
	self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	self.selectionStyle = UITableViewCellSelectionStyleBlue;
	self.textLabel.text = ((SystemSettingItem*)_item).text;
    self.captionLabel.textColor = RGBCOLOR(135, 135, 135);
	self.captionLabel.text = ((SystemSettingItem*)_item).caption;
    self.captionLabel.highlightedTextColor = RGBCOLOR(135, 135, 135);
    self.captionLabel.textAlignment = UITextAlignmentRight;
	self.textLabel.font = TTSTYLEVAR(tableFont);
	self.textLabel.textColor = TTSTYLEVAR(textColor);
	self.textLabel.textAlignment = UITextAlignmentLeft;
	
//	UIImage *accessoryImage = [UIImage imageNamed:@"Disclosure.png"];
//	UIImageView *accImageView = [[UIImageView alloc] initWithImage:accessoryImage];
//	accImageView.userInteractionEnabled = YES;
//	[accImageView setFrame:CGRectMake(0, 0, 15, 15)];
//	self.accessoryView = accImageView;
//	[accImageView release];
    
    self.imageView2.contentMode = UIViewContentModeScaleAspectFit;
    
    if ([((SystemSettingItem*)_item).imageURL isEmptyOrWhitespace]) {
        self.imageView2.hidden = YES;
    }else{
        self.textLabel.font = [UIFont systemFontOfSize:14];
        self.imageView2.hidden = NO;
    }
}

@end
