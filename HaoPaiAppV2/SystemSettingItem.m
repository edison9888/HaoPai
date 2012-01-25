//
//  SystemSettingItem.m
//  Cookbook
//
//  Created by 高飞 on 11-9-5.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SystemSettingItem.h"


@implementation SystemSettingItem
@synthesize caption = _caption;

-(void) dealloc{
	TT_RELEASE_SAFELY(_caption);
	[super dealloc];
}

+ (id)itemWithText:(NSString*)text caption:(NSString*)caption imageURL:(NSString*)imageURL{
	SystemSettingItem* item = [[[self alloc] init] autorelease];
	item.text = text;
	item.caption = caption;
	item.imageURL = imageURL;
	return item;
}


@end
