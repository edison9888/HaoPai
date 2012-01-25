//
//  MyStyleCell.h
//  HaoPaiApp
//
//  Created by 高飞 on 11-7-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//



@interface MyStyleCell : TTTableLinkedItemCell {
	TTStyledTextLabel* styleLabel;
	UIView *_line;
}
@property (nonatomic, readonly) UIView *line;
@property (nonatomic, readonly) TTStyledTextLabel *styleLabel;

@end
