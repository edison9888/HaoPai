//
//  SynchronousItemCell.h
//  HaoPaiApp
//
//  Created by 高飞 on 11-6-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

@class SynchronousItem;

@interface SynchronousItemCell : TTTableViewCell {
	SynchronousItem*    _item;
	UIControl*          _control;
	TTImageView*        _icoImage;
     UIView *_line;
}

@property (nonatomic, readonly, retain) TTTableControlItem* item;
@property (nonatomic, readonly, retain) UIControl*          control;
@property (nonatomic, readonly) TTImageView *icoImage;
@property (nonatomic, readonly) IBOutlet UIView *line;
@end
