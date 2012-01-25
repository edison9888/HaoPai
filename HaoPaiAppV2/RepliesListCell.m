//
//  RepliesListCell.m
//  HaoPaiAppV2
//
//  Created by 高飞 on 11-12-26.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "RepliesListCell.h"
#import "UIImageView+WebCache.h"
@implementation RepliesListCell
-(void) dealloc{
	TT_RELEASE_SAFELY(_userList);
    TT_RELEASE_SAFELY(_iconLeft);
    TT_RELEASE_SAFELY(_iconRight);
	[super dealloc];
}

+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object{
    return  51;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.userList.frame = CGRectMake(0, 0, 320, 50);
    self.iconLeft.frame = CGRectMake(0, 0, 11, 48);
    self.iconRight.frame = CGRectMake((320-10), 0, 11, 48);
}

-(void)setObject:(id)object{
    [super setObject:object];
    self.accessoryType = UITableViewCellAccessoryNone;
	self.selectionStyle = UITableViewCellSelectionStyleNone;
    UIImageView *_back = [[UIImageView alloc] initWithImage:[TTIMAGE(@"bundle://bean-list-bg.png") 
                                                             stretchableImageWithLeftCapWidth:1 
                                                             topCapHeight:1]];
    self.backgroundView =  _back;
    [_back release];
    
    //self.backgroundColor = RGBCOLOR(247, 245, 239);
}

-(UIImageView *)iconLeft{
    if (!_iconLeft) {
        _iconLeft = [[UIImageView alloc] initWithImage:TTIMAGE(@"bundle://scroll-img-icon-left.png")];
        _iconLeft.backgroundColor = RGBCOLOR(247, 245, 239);
        _iconLeft.contentMode = UIViewContentModeCenter;
        [self addSubview:_iconLeft];
    }
    return _iconLeft;
}


-(UIImageView *)iconRight{
    if (!_iconRight) {
        _iconRight = [[UIImageView alloc] initWithImage:TTIMAGE(@"bundle://scroll-img-icon-right.png")];
        _iconRight.backgroundColor = RGBCOLOR(247, 245, 239);
        _iconRight.contentMode = UIViewContentModeCenter;
        [self addSubview:_iconRight];
    }
    return _iconRight;
}

-(iCarousel *) userList{
	if (!_userList) {
        _userList = [[iCarousel alloc] init];
		_userList.type = iCarouselTypeLinear;
        _userList.delegate = self;
        _userList.dataSource = self;
        _userList.scrollSpeed = 0.8;
        //_userList.contentOffset = CGSizeMake(-128, 0);
		[self addSubview:_userList];
	}
	return _userList;
}




- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index
{
	NSString *imageFrame = [NSString stringWithFormat:@"bundle://%d.jpg",index];

	UIImageView *_frame = [[[UIImageView alloc] initWithImage:TTIMAGE(imageFrame)] autorelease];
	_frame.frame = CGRectMake(0, 0, 32, 32);
	return _frame;
}

- (float)carouselItemWidth:(iCarousel *)carousel
{
    //slightly wider than item view
    return 43;
}

-(NSUInteger)numberOfVisibleItemsInCarousel:(iCarousel *)carousel{
    return 9;
}

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return 13;
}

- (CATransform3D)carousel:(iCarousel *)carousel transformForItemView:(UIView *)view withOffset:(float)offset
{
    //implement 'flip3D' style carousel
    
    //set opacity based on distance from camera
    view.alpha = 1.0 - fminf(fmaxf(offset, 0.0), 1.0);
    
    //do 3d transform
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = carousel.perspective;
    transform = CATransform3DRotate(transform, M_PI / 8.0, 0, 1.0, 0);
    return CATransform3DTranslate(transform, 0.0, 0.0, offset * carousel.itemWidth);
}

- (UIView *)carousel:(iCarousel *)carousel placeholderViewAtIndex:(NSUInteger)index
{
	//create a placeholder view
	return nil;
}

@end
