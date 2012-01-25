//
//  SynchronousItemCell.m
//  HaoPaiApp
//
//  Created by 高飞 on 11-6-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SynchronousItemCell.h"
#import "SynchronousItem.h"
#import "Three20UI/UIViewAdditions.h"

static const CGFloat kDefaultTextViewLines = 5;
static const CGFloat kControlPadding = 8;

@implementation SynchronousItemCell

@synthesize item    = _item;
@synthesize control = _control;


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier {
	if (self = [super initWithStyle:style reuseIdentifier:identifier]) {
		self.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	
	return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	TT_RELEASE_SAFELY(_item);
	TT_RELEASE_SAFELY(_control);
	TT_RELEASE_SAFELY(_icoImage);
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews {
	[super layoutSubviews];
    [self _commonInit];
	self.icoImage.frame = CGRectMake(10, 5, 30, 32);
	self.icoImage.urlPath = _item.imageUrl;
	self.textLabel.frame = CGRectMake(45, 10, 150, 21);
    self.line.frame = CGRectMake(0, 44, 320, 0.5);
	if ([TTTableControlCell shouldSizeControlToFit:_control]) {
		_control.frame = CGRectInset(self.contentView.bounds, 2, kTableCellSpacing / 2);
		
	} else {
		CGFloat minX = kControlPadding;
		CGFloat contentWidth = self.contentView.width - kControlPadding;
		if (![TTTableControlCell shouldRespectControlPadding:_control]) {
			contentWidth -= kControlPadding;
		}
		if (self.textLabel.text.length) {
			CGSize textSize = [self.textLabel sizeThatFits:self.contentView.bounds.size];
			contentWidth -= textSize.width + kTableCellSpacing;
			minX += textSize.width + kTableCellSpacing;
		}
		
		if (!_control.height) {
			[_control sizeToFit];
		}
		
		if ([TTTableControlCell shouldConsiderControlIntrinsicSize:_control]) {
			minX += contentWidth - _control.width;
		}
		
		// XXXjoe For some reason I need to re-add the control as a subview or else
		// the re-use of the cell will cause the control to fail to paint itself on occasion
		[self.contentView addSubview:_control];
		_control.frame = CGRectMake(minX, floor(self.contentView.height/2 - _control.height/2),
									contentWidth, _control.height);
	}
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


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)object {
	return _item ? _item : (id)_control;
}

-(TTImageView *) icoImage{
	if (!_icoImage) {
		_icoImage = [[TTImageView alloc] init];
		[self.contentView addSubview:_icoImage];
	}
	return _icoImage;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object {
	if (object != _control && object != _item) {
		[_control removeFromSuperview];
		TT_RELEASE_SAFELY(_control);
		TT_RELEASE_SAFELY(_item);
		
		if ([object isKindOfClass:[UIView class]]) {
			_control = [object retain];
			
		} else if ([object isKindOfClass:[SynchronousItem class]]) {
			_item = [object retain];
			_control = [_item.control retain];
		}
		
		_control.backgroundColor = [UIColor clearColor];
		self.textLabel.text = _item.caption;
		self.textLabel.font = [UIFont boldSystemFontOfSize:15];
		if (_control) {
			[self.contentView addSubview:_control];
		}
	}
}



@end
