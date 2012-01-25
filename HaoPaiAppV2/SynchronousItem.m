//
//  SynchronousItem.m
//  HaoPaiApp
//
//  Created by 高飞 on 11-6-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SynchronousItem.h"


@implementation SynchronousItem
@synthesize imageUrl;

-(void) dealloc{
	TT_RELEASE_SAFELY(_imageUrl);
	[super dealloc];
}

@end
