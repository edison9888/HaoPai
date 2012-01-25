//
//  SystemSettingItem.h
//  Cookbook
//
//  Created by 高飞 on 11-9-5.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


@interface SystemSettingItem : TTTableImageItem {
	NSString* _caption;
}
@property (nonatomic, copy) NSString* caption;
+ (id)itemWithText:(NSString*)text caption:(NSString*)caption imageURL:(NSString*)imageURL;
@end
